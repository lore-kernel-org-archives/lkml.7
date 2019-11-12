Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EB1C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5817720818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6K0GT66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKLSgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:36:10 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44186 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKLSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:36:09 -0500
Received: by mail-il1-f196.google.com with SMTP id i6so16459129ilr.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pt+Eiiq/E3aycrVMhn1krJyuGOpfFcyGAVCaAM8khkU=;
        b=f6K0GT66CzhSK/ru9GwCp5nsZpF/byuB2/tBzi+H5ZVbqtqipkO4CYxbvjXBMBXUvK
         YLcl8i2AB/HlfTzxiOYLksHji6gKTh5t7UTqCWFEIyXMI1wPzqm31OhXptGE+imOKxHm
         +5HOOpK1JsITDHjr6Y4XktnW5KqAoM267ax3nr4dwAHPkn/eDHgkMBhzrf2VMeHBcdWI
         FVa2i0UwMTOiZz7oS06zZxkPjv/c6YEwVDuV95ckL2jf8h86P+mC/gOVkhlccR8wUIiA
         b+2c4Dq9zX2nMhXQcDN6GNf/8CMGzC+lVincUyYI62Hhkfvsya1bzQ6iKUYz1DdmOy7P
         32JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt+Eiiq/E3aycrVMhn1krJyuGOpfFcyGAVCaAM8khkU=;
        b=cYacE0SI8XA7qT8Z1wSanq2aGXBldQzv+S8YvnYt/1XkJsrvE8jeajl9CUkwxhvAT2
         WHaCZxbBk38J9Dia7XAkV/RDyg9Iih9roYX4SD37iC+MI5sQQwWnht0oBwUMfrMx++i8
         3324iDooPfmJrgowAw+KSGVVjvbh9vLs9UXtdnYNoH6OywXPre/t+u7yr5skhX01sOOA
         q9EtjXUiOmmtN1UidbhLmBvU2fyPFnaAQ3K9bZvRWoJRDSs9Z7Ffa+ATEVkvJ9dubyL9
         THWfvKHS4YeVUHizV5J9a0HuthDq8T8Hmsvksc91y9rtPBBF9Xn0D0150SGygClPJdbo
         fLxg==
X-Gm-Message-State: APjAAAXzPIKmC3KUSol5ug3jUtjKw7aS0/e7r7+BqK/g8twXP2HULAW7
        1JDrkDymjVtAQ+JJhM2M4dIsIrQsCtPr90eF9DOyOA==
X-Google-Smtp-Source: APXvYqz5+MDxQicmVyuoGMe0YErdTWD+n8Ty2EHjM180dTfeNxqN/ppUeFXbr5EJxvOXKr1iys9Y0EKGkhTHzsoVq3U=
X-Received: by 2002:a92:9adb:: with SMTP id c88mr37066861ill.193.1573583767237;
 Tue, 12 Nov 2019 10:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20190710201244.25195-1-brijesh.singh@amd.com> <20190710201244.25195-2-brijesh.singh@amd.com>
In-Reply-To: <20190710201244.25195-2-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 12 Nov 2019 10:35:55 -0800
Message-ID: <CAMkAt6pzXrZw1TZgcX-G0wDNZBjf=1bQdErAJTxfzYQ2MJDZvw@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] KVM: SVM: Add KVM_SEV SEND_START command
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 1:13 PM Singh, Brijesh <brijesh.singh@amd.com> wrote:
>
> +static int sev_send_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +       void *amd_cert = NULL, *session_data = NULL;
> +       void *pdh_cert = NULL, *plat_cert = NULL;
> +       struct sev_data_send_start *data = NULL;
> +       struct kvm_sev_send_start params;
> +       int ret;
> +
> +       if (!sev_guest(kvm))
> +               return -ENOTTY;
> +
> +       if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
> +                               sizeof(struct kvm_sev_send_start)))
> +               return -EFAULT;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       /* userspace wants to query the session length */
> +       if (!params.session_len)
> +               goto cmd;
> +
> +       if (!params.pdh_cert_uaddr || !params.pdh_cert_len ||
> +           !params.session_uaddr)
> +               return -EINVAL;

I think pdh_cert is only required if the guest policy SEV bit is set.
Can pdh_cert be optional?

> +
> +       /* copy the certificate blobs from userspace */
> +       pdh_cert = psp_copy_user_blob(params.pdh_cert_uaddr, params.pdh_cert_len);
> +       if (IS_ERR(pdh_cert)) {
> +               ret = PTR_ERR(pdh_cert);
> +               goto e_free;
> +       }
> +
> +       data->pdh_cert_address = __psp_pa(pdh_cert);
> +       data->pdh_cert_len = params.pdh_cert_len;
> +
> +       plat_cert = psp_copy_user_blob(params.plat_cert_uaddr, params.plat_cert_len);
> +       if (IS_ERR(plat_cert)) {
> +               ret = PTR_ERR(plat_cert);
> +               goto e_free_pdh;
> +       }

I think plat_cert is also only required if the guest policy SEV bit is
set. Can plat_cert also be optional?

> +
> +       data->plat_cert_address = __psp_pa(plat_cert);
> +       data->plat_cert_len = params.plat_cert_len;
> +
> +       amd_cert = psp_copy_user_blob(params.amd_cert_uaddr, params.amd_cert_len);
> +       if (IS_ERR(amd_cert)) {
> +               ret = PTR_ERR(amd_cert);
> +               goto e_free_plat_cert;
> +       }

I think amd_cert is also only required if the guest policy SEV bit is
set. Can amd_cert also be optional?

> +
> +       data->amd_cert_address = __psp_pa(amd_cert);
> +       data->amd_cert_len = params.amd_cert_len;
> +
> +       ret = -EINVAL;
> +       if (params.session_len > SEV_FW_BLOB_MAX_SIZE)
> +               goto e_free_amd_cert;
> +
> +       ret = -ENOMEM;
> +       session_data = kmalloc(params.session_len, GFP_KERNEL);
> +       if (!session_data)
> +               goto e_free_amd_cert;

This pattern of returning -EINVAL if a length is greater than
SEV_FW_BLOB_MAX_SIZE and -ENOMEM if kmalloc fails is used at
sev_launch_measure. And I think in your later patches you do similar,
did you consider factoring this out into a helper function similar to
psp_copy_user_blob?
