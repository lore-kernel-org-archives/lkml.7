Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E44ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC0920684
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZItP+0oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbfJWGzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:55:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38326 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJWGzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:55:09 -0400
Received: by mail-yw1-f67.google.com with SMTP id s6so7113817ywe.5;
        Tue, 22 Oct 2019 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWMfIewyW2yZnqk9iPz3LngqD0QBboavwiUrFcIU6Tk=;
        b=ZItP+0oobmwxRWpFscmdU9mtpw5Ngc7+Ab8AeULxE3u2I5by5dse+l/thhFQYJOI5o
         KNTsWo9qU/mp7tYu8GXzSY/+Cc1E7rl4FQT2awWeV5y8TsFR6YOll5izd7L2Hxj17dli
         x+LQV/nU6tJmX9KKR4UoJIXkFZd2Pp0BW9HQkuNJuJEtuNJsGPDz4YrRctEuW7Wo4NQ4
         mlYsZ2feJsgiMR697WQzGmsyWaa9SwhBoTRJkIhV3/lHwOmhiM0eKNaBTxKS7krOKklW
         IqUtxPA0HFb/pASs89Wb847XvRKiwfO/6dTwqtGeMuzQGibs89yMYZmmT+75ctCNzJWi
         Ha/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWMfIewyW2yZnqk9iPz3LngqD0QBboavwiUrFcIU6Tk=;
        b=DegaDjv2ReQ3rXR3DvCCDa6pY9FWBLaA9FZIQd6dpgyBNaMKJRK1DLmhaa8AFXJZTB
         gEZXMqJ3oTWm6aFPILj5DCAUvlDAP8SiD0PudBzbl15JXewbaJQ6GcRDAw+nxKuTxNli
         UvDSN8dXrelq53tHujunYvn7u4xrvFSuW71kgiWHP8djxGAjiNoZTAf+jg32Q3LpeqD4
         IV1hX7GewzQGMi45bMdY9XvOOU1TCzjRh3AojU9paMxyS45lrpNG5eY0vw27QaIKozcO
         ti7R9FTBzLZKdyobNzUPS5bGlxhQH15JjrDbjpu36EJWlDXJjqIgeNSYdHUJ30mFi85S
         KmkQ==
X-Gm-Message-State: APjAAAUIBAMUW102UX6qeah1nbZj5IXKZjGH29KDVU9zQnbiMP3BLiwC
        L2Y/25WvoRiaNS5TnGYTbeD8ayBsxh24pYkCa9g=
X-Google-Smtp-Source: APXvYqyK0RBRSgeWbGn7/LkyjHCNbkCod4NzmBkwYNzSbYnoQBKsqwCBuMw2+GUec7foLcGq8YHoQC9v4cNSmSY2L94=
X-Received: by 2002:a81:6c58:: with SMTP id h85mr1527436ywc.88.1571813708118;
 Tue, 22 Oct 2019 23:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191022204453.97058-1-salyzyn@android.com>
In-Reply-To: <20191022204453.97058-1-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Oct 2019 09:54:57 +0300
Message-ID: <CAOQ4uxjFqq0zA7V3A9s0h2om7AWY5AT-2sQ4z2G0Vk2gtf1M=w@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] overlayfs override_creds=off & nested get xattr fix
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:45 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Patch series:
>
> Mark Salyzyn (5):
>   Add flags option to get xattr method paired to __vfs_getxattr
>   overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
>   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>   overlayfs: internal getxattr operations without sepolicy checking
>   overlayfs: override_creds=off option bypass creator_cred
>
> The first four patches address fundamental security issues that should
> be solved regardless of the override_creds=off feature.
>
> The fifth adds the feature depends on these other fixes.
>
> By default, all access to the upper, lower and work directories is the
> recorded mounter's MAC and DAC credentials.  The incoming accesses are
> checked against the caller's credentials.
>
> If the principles of least privilege are applied for sepolicy, the
> mounter's credentials might not overlap the credentials of the caller's
> when accessing the overlayfs filesystem.  For example, a file that a
> lower DAC privileged caller can execute, is MAC denied to the
> generally higher DAC privileged mounter, to prevent an attack vector.
>
> We add the option to turn off override_creds in the mount options; all
> subsequent operations after mount on the filesystem will be only the
> caller's credentials.  The module boolean parameter and mount option
> override_creds is also added as a presence check for this "feature",
> existence of /sys/module/overlay/parameters/overlay_creds
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> v14:
> - Rejoin, rebase and a few adjustments.
>
> v13:
> - Pull out first patch and try to get it in alone feedback, some
>   Acks, and then <crickets> because people forgot why we were doing i.

Mark,

I do not see the first patch on fsdevel
and I am confused from all the suggested APIs
I recall Christoph's comment on v8 for not using xattr_gs_args
and just adding flags to existing get() method.
I agree to that comment.

I remember asking - don't remember the answer -
do you have any testing for this feature?
I have a WIP branch to run unionmount-testsuite not as root,
which is a start, but I didn't get to finish the work.
Let me know if you want to take up this work.

Thanks,
Amir.
