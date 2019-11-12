Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3B5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0369721A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeWVqyPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKLWXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:23:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34394 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLWXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:23:20 -0500
Received: by mail-io1-f66.google.com with SMTP id q83so198735iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbZ0FLEIJqgDx32ZuWy0vmHvCIKwfGbPT6f4crP6il4=;
        b=CeWVqyPzHeOhROoKK0J3Fdo/f76ed5+fmpKwaBgWiZqVDAbXxMQAHBc3Lfxh1AIiyM
         lFLjI4oOwsKRwzX8bvRIYMTnj8UYpVCVYjvPJynCVVewHryQND+dBS3jEvMe1RjlsY0/
         yPMQH9sjPQUBRYEdl24nXBlrj4Q5Q5SujTGHbgOQD8mhO5GJ+j/N9zffO7A1z/+25RJl
         9OX4jcRNIuNaWo5wrV9aWpuLDKUGRZnRAqNfpv0/x23e4cwxKJ1ogN1wpi6RbyriQCop
         a9HuGZZG7JzYy67xTdUTIVmhOtCoNvaQUd+Sv+zmTUGfTz/M1NYwcCdYWshj+QF489ON
         TBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbZ0FLEIJqgDx32ZuWy0vmHvCIKwfGbPT6f4crP6il4=;
        b=MH4BDudnkoOqXB2GNnYJtIeyOXrDzBY0QarWWQgUGk/24Md8uFGCIQDEVTohlGMvAZ
         TULN7zDgN5yzMuaXHJxG+4HcXhNwGFbudeInFSqskjmyAQjM8YP1qXwvKGxOBKzw77L0
         kT3i05I8TojyPZzCscJzo2MhJEMVHgRu7YtNiTSC1gpKwdGXa2o2/kJKRntI0yLC/m+w
         Gn/8c2UE0A7BSRUn5N06h8fQOzE0kU1iLH3MGnqRnsZkqGmeE+oNtBnox3+M2C8I5zjR
         eoWsJqK5WToHOdZZm2+2oZ2wtMi6fSfY+gti/BX/lG8d1CC/IrSWd6ori5RW2yOtsB2/
         QBng==
X-Gm-Message-State: APjAAAVakrmyfobpXPfSvtw/q1jnro4YJ+c+iZnYTVN1rRcgwSvLFlvb
        Vsc53PTfVRG0iZF23N5qFoZoR4E9TFxbRPMaAxmGpQ==
X-Google-Smtp-Source: APXvYqypWtcoEAVe1rmRQXFP0GxfFoIz/oTB3CdmlIdpAOChTwJSW+V8HVU26HCt6ORtpz9NYpp10toDfp0GJDhpUzI=
X-Received: by 2002:a6b:c9ce:: with SMTP id z197mr315197iof.14.1573597398002;
 Tue, 12 Nov 2019 14:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20190710201244.25195-1-brijesh.singh@amd.com> <20190710201244.25195-3-brijesh.singh@amd.com>
In-Reply-To: <20190710201244.25195-3-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 12 Nov 2019 14:23:06 -0800
Message-ID: <CAMkAt6rrwWteTaA4zJO1D3qd12P+8Qa68hjwsSEb+0AVcsjk7A@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] KVM: SVM: Add KVM_SEND_UPDATE_DATA command
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

On Wed, Jul 10, 2019 at 1:14 PM Singh, Brijesh <brijesh.singh@amd.com> wrote:

> +static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +       struct sev_data_send_update_data *data;
> +       struct kvm_sev_send_update_data params;
> +       void *hdr = NULL, *trans_data = NULL;
> +       struct page **guest_page = NULL;
> +       unsigned long n;
> +       int ret, offset;
> +
> +       if (!sev_guest(kvm))
> +               return -ENOTTY;
> +
> +       if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
> +                       sizeof(struct kvm_sev_send_update_data)))
> +               return -EFAULT;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       /* userspace wants to query either header or trans length */
> +       if (!params.trans_len || !params.hdr_len)
> +               goto cmd;
> +
> +       ret = -EINVAL;
> +       if (!params.trans_uaddr || !params.guest_uaddr ||
> +           !params.guest_len || !params.hdr_uaddr)
> +               goto e_free;
> +
> +       /* Check if we are crossing the page boundry */
> +       ret = -EINVAL;
> +       offset = params.guest_uaddr & (PAGE_SIZE - 1);
> +       if ((params.guest_len + offset > PAGE_SIZE))
> +               goto e_free;
> +
> +       ret = -ENOMEM;
> +       hdr = kmalloc(params.hdr_len, GFP_KERNEL);
> +       if (!hdr)
> +               goto e_free;

Should we be checking params.hdr_len against SEV_FW_BLOB_MAX_SIZE?

> +
> +       data->hdr_address = __psp_pa(hdr);
> +       data->hdr_len = params.hdr_len;
> +
> +       ret = -ENOMEM;
> +       trans_data = kmalloc(params.trans_len, GFP_KERNEL);
> +       if (!trans_data)
> +               goto e_free;

Ditto, should we be checking params.hdr_len against SEV_FW_BLOB_MAX_SIZE?
