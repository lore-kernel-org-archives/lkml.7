Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B1CC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F272051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Zn1NnICI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgAGCN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:13:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41612 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgAGCNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:13:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so53034709ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 18:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTvmZAi1eNtjs4sTxVjFLMcqqiQSeyyEiy8ncU1xv3c=;
        b=Zn1NnICIh7lw8ft++YJmU02ouc0v+mOdsmw7apgl7TkbZ9TWfzwAttkBAtYDRjvzcB
         0uuBeRMX0aWKBC62OXnUNzftxLu+D0uGv7MS/09TFIBrWbotFpSeQQj64ppCCQqGGGHq
         hEGs6IdFjVNgCd1foX04IktMibEMlqB7u2OWZ2Cwqp295IM/iVyHR8DFM+b29YtgDCO+
         BJdQD4QWH+GvoWlUDNUKBX9VOTz0W3F615/hlOBLTKgRbT/YmGzvVOx2OSclhNFNkDEk
         J3DGseUoOHN/+efVYeq5SBYJmuCvVGNCxVk5uZGzXgxHSH37qhFkrr4A8M0MsnYpmm7V
         8yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTvmZAi1eNtjs4sTxVjFLMcqqiQSeyyEiy8ncU1xv3c=;
        b=ZSfbQQraYGUdCnyYZDeVNwBqBCb/LoqpAEBhxxqcRF9DFNMv0py2/oUrIZ44i0nbxV
         Q7+UuWzG93Yx0uxTP/3tLJa62yGjNhB2Eau8b6p8/8HzZNDVoava+kiM2VzTe8eQfkQd
         umOWTmzxbyW9y74c0oP+i+nNUkIqAi2UbpLZNZBSqMnt2sCfIMXUcaW2PBK1tQXe6P6w
         3bptxgEzdaQ6pMquZQ/HegJgcvOU2lW4CnmULZo0sb4tXW+q/EKCTYMZx+soDZDToVPh
         L7nZ/N3qQPbdYFrVItX9tcqx4U8jRd8f8L9WYkWFKvhcj7eE6Y85kKVeGal9m4/SZphR
         Y2kw==
X-Gm-Message-State: APjAAAVpV+rHEfos71p7Ib+BeUV9TTIBWL68UDxHBpo6MCMOuqScjbzU
        qaL3KzMZgZxLSKsJJxQ2WBRuZ8w5CnWMMPO7s4wO
X-Google-Smtp-Source: APXvYqwNi+fVGeWr70/qIgzTZhyuT12r70Pi/j7YMrg14zhqbTSq+OtdXFDdYNkEW1NXBXwSLfDKCne/GE/kd21nVJI=
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr54540424ljj.225.1578363233725;
 Mon, 06 Jan 2020 18:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20200106181329.167322-1-hridya@google.com> <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
 <CA+wgaPMHWOVYo_pVeYuvj6CrQOgy9=vQco+tnGHjPX3=CLh5wA@mail.gmail.com> <c1354989-1e08-1433-f2c0-5984da341cf5@tycho.nsa.gov>
In-Reply-To: <c1354989-1e08-1433-f2c0-5984da341cf5@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Jan 2020 21:13:42 -0500
Message-ID: <CAHC9VhQg-fY2qTbOxZ0fbTSNHiNDGU+1SOzRxaw5DcSrX2hppQ@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labelling for binderfs
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 2:33 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/6/20 2:06 PM, Hridya Valsaraju wrote:
> > On Mon, Jan 6, 2020 at 10:33 AM 'Stephen Smalley' via kernel-team
> > <kernel-team@android.com> wrote:
> >>
> >> On 1/6/20 1:13 PM, Hridya Valsaraju wrote:
> >>> This patch allows genfscon per-file labeling for binderfs.
> >>> This is required to have separate permissions to allow
> >>> access to binder, hwbinder and vndbinder devices which are
> >>> relocating to binderfs.
> >>>
> >>> Acked-by: Jeff Vander Stoep <jeffv@google.com>
> >>> Acked-by: Mark Salyzyn <salyzyn@android.com>
> >>> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> >>
> >> Do you want binderfs to also support userspace labeling of files via
> >> setxattr()?  If so, you'll want to also add it to
> >> selinux_is_genfs_special_handling() as well.
> >
> > Thank you for the quick response Stephen :) I cannot think of a
> > use-case for the userspace labelling of files in binderfs via
> > setxattr() as of now. I
> > will make the change if one comes up!
>
> Ok, then you can include my:
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Merged into selinux/next, thanks everyone!

-- 
paul moore
www.paul-moore.com
