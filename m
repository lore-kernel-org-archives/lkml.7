Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10250C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9C22080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fwB85im7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLIQ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:58:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1OCLjEQuYoi4QAYTjhYjwRqTrdb1wvtNuRiMHSGYyqI=; b=fwB85im7C+ehN2sQadu++gABL
        MET9UX7l2NVJTQ4/3dsOXTeWX4MI2rDfCs4Wz4B81AgRFi2WyaoBwfjj+vefpexY//w4UN/YdTsdL
        m7dUJQhblzzMS19wXocvKsAbHf/r1ocqOZFglenE1XslLoG87rZ27nlMQP9JuHjMNih7Uf6CgYsdS
        jbAxkbNUiupdipiMxPC0EYfRfpbhBFcq+ZqwRlWv989q/0TxlDcUKP0898GLTcbWrcJSFaTO/9nmc
        FePjZ1dOmOCeBOasPpBThxusntVctSP3LwmBfBoRNrepLJfEGNRpG3jQTr6x9XOvC027ygbYcOWqL
        0FkTgFJxA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieMN8-00086y-7i; Mon, 09 Dec 2019 16:58:58 +0000
Date:   Mon, 9 Dec 2019 08:58:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Documentation: x86: fix boot.rst warning and format
Message-ID: <20191209165858.GE32169@bombadil.infradead.org>
References: <c6fbf592-0aca-69d9-e903-e869221a041a@infradead.org>
 <20191209161340.kdsikc2hvbhmpi6k@tomti.i.net-space.pl>
 <a934c91b-0c9f-59d4-ee44-bcd7e9b20334@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a934c91b-0c9f-59d4-ee44-bcd7e9b20334@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 08:26:17AM -0800, Randy Dunlap wrote:
> On 12/9/19 8:13 AM, Daniel Kiper wrote:
> > What can I do next time to avoid mistakes like that? I suppose that
> > I can run something to get this warning but I do not know what exactly
> > it should be.
> 
> I just do:
> $ mkdir DOC1
> $ make O=DOC1 htmldocs &>doc1.out
> 
> doc1.out will contain the build log for the documentation.
> It will be large.  :(
> Just grep (or use editor search) for the file(s) that you are
> interested in.

"make W=1" will show warnings from the kernel-doc program without going to
the trouble of building the documentation.  We can enable it by default
once the number of extra warnings it produces is reduced significantly
(in November 2017 it was 1300).
