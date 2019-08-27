Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12668C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74AF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBIsrc0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfH0Q5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:57:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43661 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbfH0Q5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:57:37 -0400
Received: by mail-io1-f67.google.com with SMTP id 18so47861884ioe.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGOUb6qETbWsgAJoalsCTFlAvdsb83uQVVXs/w4mwBE=;
        b=VBIsrc0k26FUtEar2ReJlFb0cg8xeFC2xexRrOXNtYtYJjLoug03whgz8WJlzMuaDQ
         7JK4jplpFQZ8tCMjKW8F2AKSdfMe0/ceSV/ixQVYo8W2MIizdFxT8C1GuY3dusICVPE3
         z9vUBtjOJBJHbjPFAkhEj8hvRBhAV5Tw5YgAnSzqZLgkZnELvo83/PqcA7lmTe/S/ZYP
         v8XbQGjooZ8kU2BJ7I32GgDLo3l1CeWZUn5JoE5AExetPx0bpdPSN0DF8uknSNTZBYgR
         FGKhWxbUpCK7/lSfOHMiIVnProPheI9lKMJfp0/Ck1ye3VbZdIJYUJ49YgjOtyEWc1qO
         GATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGOUb6qETbWsgAJoalsCTFlAvdsb83uQVVXs/w4mwBE=;
        b=HmG7Of8nWD8qOV2qVhgka6QzPT6hnkkGXL+d8F2nPAUD1EajL+bS+AzFOolC2U+/kY
         J9jei1T3l60aM3cSY0FpQzt6FLB2JIoZT8KPk3YZQcEnRBQVB0iwUaUQvmPo/SGaU67S
         M7DW9J0W0hWErsNvHLcnVBT55srWCDpklR/gVebBvOACvlKKlDA6L28PdYmRKmejlsnH
         8HTxjZHsTPLSCsSW4smdxq6w8FzCjy7aYSCGxveq4pccyxtNdEF7bLoV5k8qheyzmB5a
         8BtM5TDFqvYh6dGFSw9GBZ3U4dqiuH+nRy23HeMxEhSSIwUWzMtIxlZAuVnpmRJIQckj
         alTQ==
X-Gm-Message-State: APjAAAUz6N4Fl3MQ6uPOWJstxeIJso3DQBQnaXY68p33bhLvFDv/reZH
        JjrRx5XzG9YMOKsil+LdwRFp9F2zRT0dASloRJxzsg==
X-Google-Smtp-Source: APXvYqw5P+1iPQwzpQ0PkMddqAw7dDWHOpCeRE8Gzm38lrWZHgeRKZTaqN/9e3LzgB/+45/Suy7SL7Xu8mCoHsnZz8g=
X-Received: by 2002:a5e:a811:: with SMTP id c17mr326399ioa.122.1566925056306;
 Tue, 27 Aug 2019 09:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190827160404.14098-1-vkuznets@redhat.com> <20190827160404.14098-3-vkuznets@redhat.com>
In-Reply-To: <20190827160404.14098-3-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 27 Aug 2019 09:57:25 -0700
Message-ID: <CALMp9eTE4JsUsU2CRE-Y04_nuqpjav1YohuW8SsSdh+m8s=7mw@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: svm: remove unneeded nested_enable_evmcs() hook
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 9:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Since commit 5158917c7b019 ("KVM: x86: nVMX: Allow nested_enable_evmcs to
> be NULL") the code in x86.c is prepared to see nested_enable_evmcs being
> NULL and in VMX case it actually is when nesting is disabled. Remove the
> unneeded stub from SVM code.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
