Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B8FC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACD2215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyNVCzKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbfJDRZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:25:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45804 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfJDRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:25:53 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so15139195iot.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dln16A/W/aPbVdMkSQRzgwCwqw5DgFXnqTMZ/X92lyY=;
        b=TyNVCzKV0HTmPH2eFsbRtlwfpfFI5+Px6YsQ2MJIblNuMSp86y7OqSPzbJqIwBeez5
         msf2tBIAJhbZNVvZCCs7w/OJtagUgilEFr9TV/xCt1mi+HucRH8kOy7KPAH76xSX6lOk
         J5T8hfVjZaiDPZg03EUIXgQKwyTH9saUbjZblEh9i3b/pTKs0sXA9JWOkqVvrK/fgIKS
         Mx9EA9WEa/gfiGZ9tqeHfbWVpmm/wJBe8JFjQJMoZ43Wb++sEZJxSZ4tArebe4RX+Qly
         fnqH3/OZsGkCpRDxSad7WTXwnuAeSt0AjbcrmeQ2fP7OWjPeJoZglqKzbUVR0LY/JMkV
         N0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dln16A/W/aPbVdMkSQRzgwCwqw5DgFXnqTMZ/X92lyY=;
        b=NGzs2Cxh9zBcUMMUFFIX6PTdk29CAckTDBrFjea56lrlEXzICwGNQNVXlG8bBUiPAx
         7LgIBhPHmJmk/m0LiLg+oYjxYqkQKBLfEJ8l5sqZXCuFotpGXFHgj6oCHcoTIRwNDgHQ
         AoMwhb4KsPxpfP6h9DFl6uzEj7FDufXGOHh1iAoQQMNJWne76xPRfltKtgXXP1PtGhQw
         UcEuY/JVSOZgGZ0QbazUVuQ1uMV9NM75wjLXL6XBVZJnXXhnEoJz2cbt7yb3+txG4fFj
         D5ZSooJBaSxQgPW12iMAyGDBkU2L2pr6gw3mJ72mO6HSdZJbLKHa6xXvPdgpuC0/I+si
         fMWw==
X-Gm-Message-State: APjAAAXACgaIxMWkoPzWzg/ZkWWvrfG/4sdrwuyKO8ZMRmptMVdTSxm9
        lrqsaPXuLh4Yl88uwE5MwKnl+XlkuCLLpk3XIiWhzw==
X-Google-Smtp-Source: APXvYqwBnWlEPivBziVEbehucJnRyH952drSoCz/Z7vCz5BctFhJBKo9pF3Q9L8rgR0cG9sO/tcX/YyMkw4eRqpp5tI=
X-Received: by 2002:a92:8e4f:: with SMTP id k15mr18130577ilh.108.1570209951826;
 Fri, 04 Oct 2019 10:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570137447.git.thomas.lendacky@amd.com> <0fc0372d446cb559c2a5b9389c5844df7582dc50.1570137447.git.thomas.lendacky@amd.com>
In-Reply-To: <0fc0372d446cb559c2a5b9389c5844df7582dc50.1570137447.git.thomas.lendacky@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Oct 2019 10:25:40 -0700
Message-ID: <CALMp9eRe8=mJM7rTrn57sWtWVWQOj0Xhwwu=4jpYfh_PDWfAaw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: SVM: Serialize access to the SEV ASID bitmap
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:17 PM Lendacky, Thomas <Thomas.Lendacky@amd.com> wrote:
>
> From: Tom Lendacky <thomas.lendacky@amd.com>
>
> The SEV ASID bitmap currently is not protected against parallel SEV guest
> startups. This can result in an SEV guest failing to start because another
> SEV guest could have been assigned the same ASID value. Use a mutex to
> serialize access to the SEV ASID bitmap.
>
> Fixes: 1654efcbc431 ("KVM: SVM: Add KVM_SEV_INIT command")
> Tested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
