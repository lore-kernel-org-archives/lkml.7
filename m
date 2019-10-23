Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C1FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD04021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8R1L87s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfJWGRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:17:13 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39620 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJWGRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:17:13 -0400
Received: by mail-yb1-f196.google.com with SMTP id z2so5968352ybn.6;
        Tue, 22 Oct 2019 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLkh02vIJIgxySVp9Q68tYDjyHpgGV6EkLbEdLdfLuI=;
        b=M8R1L87sFQHU+HG29k8mfHzwK69D6ouADvtEPe+CMRRkYahS7FcvxzrxNoOrAscwPM
         wjYpwORmHF7Ar2V50TbmeZIw0biYZ3wResEXrDZhdkapWFsqKger13OalQ52b7Q1bRDt
         a3azbJNkm4eHBmalSyF6EZfYzzQ/rN+4LWxTlM7nSUjMOkE7bW0o0GV3OFSy0ZRHcn5h
         OiI7OpZD7zky4t51fwtYJJqIwferNmVZBsL4+3nxsf8fpt/khpzv3a/2Q0ImcSmRlnuX
         A8uabGxrzYdsv1UnmDpjSR4xNrBYN+F7oeWsnl7UTQmhAEycOV0AeHUIkvVS1UGNCQmP
         FPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLkh02vIJIgxySVp9Q68tYDjyHpgGV6EkLbEdLdfLuI=;
        b=Xxz12TM647iNG1OlUMi478zJhyMFa+lCvEoJJu3SlfejX+3ND7oemyF1z4N3IUm8Sq
         TCV92J3hBTEMWQeVUBZbyosIe/D47EUtS99rJzOrMpAH4QLNaj8ORbSP8ITweHmKuTgC
         wVGV1iT+NImhDqMJ0YdFujzaCMI4GYlcc5BSYOpB8/l47q+2uHpGzcLOTqHEYakrTKAT
         ZJrece3sK8QOINBL/lQuvJryZoGgM3lAONS9VXfFqXzzkl3Q5mWS1OAPr2Ld3EJHoa30
         yYbKAKOpcEiiaXMkav6UpSiLgzTDy6A9i16O+kvpu52pX0W7HDYmZistISLicuv2rgXB
         CSOQ==
X-Gm-Message-State: APjAAAWpKpUwBo9tfh0FJ5HPNaryulBBg44o7N5a91dGwAx/fpw1UtTC
        l7B6anwFGGkkoG7jglRuKRqMvTjmRWEECR8SHMca5w==
X-Google-Smtp-Source: APXvYqy4K8MYCexmIJSeNfWLA/Pezbb73cQldLMLRPdlTceKzXGAr2yvmL5j0lucyA05eIW9+O9Q7wuCCpjII2mbMyU=
X-Received: by 2002:a25:6607:: with SMTP id a7mr5121295ybc.144.1571811432012;
 Tue, 22 Oct 2019 23:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191022204453.97058-1-salyzyn@android.com> <20191022204453.97058-3-salyzyn@android.com>
In-Reply-To: <20191022204453.97058-3-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Oct 2019 09:17:00 +0300
Message-ID: <CAOQ4uxgE_HmVFHJ0ZEoTMotnFokD3X-TR-PiO3By84ShbSfS_Q@mail.gmail.com>
Subject: Re: [PATCH v14 2/5] overlayfs: check CAP_DAC_READ_SEARCH before
 issuing exportfs_decode_fh
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:46 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Assumption never checked, should fail if the mounter creds are not
> sufficient.
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
> Cc: kernel-team@android.com
>
> ---
> v11 + v12 +v13 + v14 - rebase
>
> v10:
> - return NULL rather than ERR_PTR(-EPERM)
> - did _not_ add it ovl_can_decode_fh() because of changes since last
>   review, suspect needs to be added to ovl_lower_uuid_ok()?
>
> v8 + v9:
> - rebase
>
> v7:
> - This time for realz
>
> v6:
> - rebase
>
> v5:
> - dependency of "overlayfs: override_creds=off option bypass creator_cred"
>
> ---
>  fs/overlayfs/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index e9717c2f7d45..9702f0d5309d 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -161,6 +161,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
>         if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
>                 return NULL;
>
> +       if (!capable(CAP_DAC_READ_SEARCH))
> +               return NULL;
> +

Shouldn't this return EPERM?

>         bytes = (fh->len - offsetof(struct ovl_fh, fid));
>         real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
>                                   bytes >> 2, (int)fh->type,
> --
> 2.23.0.866.gb869b98d4c-goog
>
