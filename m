Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E1BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8E420652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="cX5b7Kdo";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="GNp2YFGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfFIRZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:25:33 -0400
Received: from mail177-30.suw61.mandrillapp.com ([198.2.177.30]:55644 "EHLO
        mail177-30.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728970AbfFIRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:25:33 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 13:25:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=03p0EHZFqTozGokUZcGA+xQpyWGasJEVs73vt6q7z5Q=;
 b=cX5b7KdohDalO3HKYP2QPt4oEJS86bRMGBFUMQYOgjM7SwjvvLU9UGOaZENd4IOc+jFDQcrtl7HL
   9YtTXV+H7zoiPMpTDG6SSW9xJgjsPpqttLE8BzFJ7vZY8gT5v1CmCj5bfDIjldcQQWLKncXB4BAw
   udUEI3AnT/qMDWsLDmQ=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-30.suw61.mandrillapp.com id hvl0go22rtk1 for <linux-kernel@vger.kernel.org>; Sun, 9 Jun 2019 17:10:28 +0000 (envelope-from <bounce-md_31050260.5cfd3d84.v1-df138bef05124a3cb53ab538cffbb548@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560100228; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=03p0EHZFqTozGokUZcGA+xQpyWGasJEVs73vt6q7z5Q=; 
 b=GNp2YFGKIFHN28miMnLIeeGP1iQeSgvBV3e6DAB2/P7s90biBRW5cinrLnrS7ob2M4cOvU
 0RqNOWt3zZpep1nviFJjTBpAXwcW4Wv1A1TBKU5Vja/NUH/G3HyiD7HE2AIqUNw6/9f3UTR0
 YuUFQRIyefZQfn1n8cBpiGnNee/BQ=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 4.14 0/2] Fix FUSE read/write deadlock on stream-like files
Received: from [87.98.221.171] by mandrillapp.com id df138bef05124a3cb53ab538cffbb548; Sun, 09 Jun 2019 17:10:28 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190609171020.GA27685@deco.navytux.spb.ru>
References: <20190609123831.11489-1-kirr@nexedi.com> <20190609163826.GB26671@kroah.com>
In-Reply-To: <20190609163826.GB26671@kroah.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.df138bef05124a3cb53ab538cffbb548
X-Mandrill-User: md_31050260
Date:   Sun, 09 Jun 2019 17:10:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 06:38:26PM +0200, Greg KH wrote:
> On Sun, Jun 09, 2019 at 12:39:08PM +0000, Kirill Smelkov wrote:
> > Hello stable team,
> > 
> > Please consider applying the following 2 patches to Linux-4.14 stable
> > tree. The patches fix regression introduced in 3.14 where both read and
> > write started to run under lock taken, which resulted in FUSE (and many
> > other drivers) deadlocks for cases where stream-like files are used with
> > read and write being run simultaneously.
> > 
> > Please see complete problem description in upstream commit 10dce8af3422
> > ("fs: stream_open - opener for stream-like files so that read and write
> > can run simultaneously without deadlock").
> > 
> > The actual FUSE fix (upstream commit bbd84f33652f "fuse: Add
> > FOPEN_STREAM to use stream_open()") was merged into 5.2 with `Cc:
> > stable@vger.kernel.org # v3.14+` mark and is already included into 5.1,
> > 5.0 and 4.19 stable trees. However for some reason it is not (yet ?)
> > included into 4.14, 4.9, 4.4, 3.18 and 3.16 trees.
> > 
> > The patches fix a real problem into which my FUSE filesystem ran, and
> > which also likely affects OSSPD (full details are in the patches
> > description). Please consider including the fixes into 4.14 (as well as
> > into earlier stable trees - I will send corresponding series separately -
> > - one per tree).
> 
> Many thanks for these.  I've queued up all but the 3.16 patches (those
> are for Ben).
> 
> I hadn't done the backport yet, as I didn't know how "severe" this was,
> and didn't have the time to do it.  Thanks for making it easy :)

Greg, you are welcome and thanks a lot for feedback and for queueing the
patches. Ben, looking forward to 3.16 update to care about Jessie.

Thanks again,
Kirill
