Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE2520704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbT//6qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKVUiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:38:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34793 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:38:05 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so9593882iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4EY+L0eGZ4WSKeWrVoqmJLDgGRBkaxrsR16Y79FkEg=;
        b=rbT//6qY1fpKENEcz7UjkdeZ0G9BIwLj3plBAuSXus5TwMrw37kWVyChPz6Y7phbBX
         KzH6HO8sBlEjFs9AgEzBpqHjRC6sZxChsXaTv+QFyEuHrpuHqFnAdXcMzSbS87poMWc2
         sgmmUJn0hYiuILV9ecWSMWZwV9royWKR2DEt/rYKT19McfBOfZzSnLJFTE2RnfK54/6a
         UodMlkeomEdMoYn+dSoZCu1iCkqP/eFbOd9KrmYA+SaGUq0yqpCOLm++NeM2l70f+W4V
         io5QbPZUd3Mr0SPlKhBOzBHw97cmnhvGFl9P5gPBjeNgE0NNDYBSyk7H0YHnURaf3zaB
         iZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4EY+L0eGZ4WSKeWrVoqmJLDgGRBkaxrsR16Y79FkEg=;
        b=rrkhnM1Ng8MIKT9pM4LKCa7+WBWaEvdsdSaAxn0NEPtCHX42eK2rP8Ybmi5LBZWtoC
         aU04AFuUPeJHvGlVXgjK4OGkM6iAHKIznDPsQgR1S/pnpg9MrGTVmMgcZdRXeaQ0iD/4
         zOGnBNYK/vFPVeM/xpqGLnpB/g7Ju8+nW8vIAtXAK/NmjcZIIK7eHWNMFQCP2yUw57si
         C9QyPKaYpeYJvnzVbsWOerLps6vWzOHmYeyHUgT0RcsQY4/jx628FuK1TNMoXkLcS5jp
         YN3NHoQaeK/LemMtRlYRr/2b9u08kaU4YaJkpryW76tGVR7LjOtBL8ig/xxVp3fv/SB0
         W1FA==
X-Gm-Message-State: APjAAAX3qdxuo8E4kDczLQBJmMy3/pMRZ9hq4bRnO7+mAiXiAhMSmyVz
        J+RDU6gGQR1IfgigCCXhn3FdQlWQUbDBP1Ar6brkkA==
X-Google-Smtp-Source: APXvYqw5ZsjN6vcHfYbxED9Va4YQZrgZvX410QXLamUq6cXoprh45iLKHBNFHyA73grdoto1ozpgBov3t05ZstVzb7Q=
X-Received: by 2002:a5d:9b08:: with SMTP id y8mr15622207ion.108.1574455084320;
 Fri, 22 Nov 2019 12:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20191122201549.18321-1-sean.j.christopherson@intel.com>
In-Reply-To: <20191122201549.18321-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 22 Nov 2019 12:37:53 -0800
Message-ID: <CALMp9eSL0LPjOBtKpTuL-SAYUiwjrL9raMnSdX3hyW9WkO4B-g@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Remove a spurious export of a static function
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:15 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> A recent change inadvertantly exported a static function, which results
Nit: inadvertently
> in modpost throwing a warning.  Fix it.
>
> Fixes: cbbaa2727aa3 ("KVM: x86: fix presentation of TSX feature in ARCH_CAPABILITIES")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
