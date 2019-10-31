Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF386CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE077216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfJaXJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfJaXJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:09:03 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E88138665A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 23:09:02 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f8so1598561wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mATxAs5QUuHhGLu4F5uya27TIQoq4oCslUyJ/ewXecc=;
        b=Bx7Lk8Tyk5KYKRHYPLC5cBUYmhewssQNFGmSJPPLsFhNOZpVqZIIjcDXooHnEtTXkM
         ZR68IIdCfQdBJfi1iYcORajoi33/Uq3mDIXaLiljpjLAPx0ZWUg2pktLoWgyIQn1R+5I
         1OU+OcLFN9MBV1g9OB/nPPHGvkNwIbdQRbg84Vkl9W7nDfgKeL090okdy62L2JZnbbma
         IdFHYzhV53O8N8z+dufu0IsoWrUFunIlV5r+1vh//sU+yqfcHXjAGfGSrIhDW0q80jxL
         qDezuZ9jUtrHywOS+B19tgn3WlMZ09xYmra8QZPHmGk4+IR1JvEq5tri1KFK7OcIn8S/
         zXqQ==
X-Gm-Message-State: APjAAAVLETLN44WjQvhwF7nnc5cXYAR3i2dOM7vyd4ttU/PLdCXwDzkZ
        9wV4gRr3assqebYYFzm0aOFy9cE55ZZ6UO2pmgofLcHF+AsCeufJaQgOqAUR0Z4PG5+ErtbUXe4
        B96Dkg1bedz5i7dQLROtj+iCp
X-Received: by 2002:a5d:526a:: with SMTP id l10mr4422739wrc.72.1572563341599;
        Thu, 31 Oct 2019 16:09:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHKNAtsHbJkc9+5ud92PKvpwuft/n6upWOztoYCIkE5v3ubSmQnx0vJT0OfWCTVMMKSJrLyg==
X-Received: by 2002:a5d:526a:: with SMTP id l10mr4422722wrc.72.1572563341337;
        Thu, 31 Oct 2019 16:09:01 -0700 (PDT)
Received: from [192.168.20.72] (94.222.26.109.rev.sfr.net. [109.26.222.94])
        by smtp.gmail.com with ESMTPSA id u187sm5035303wme.15.2019.10.31.16.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 16:09:00 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] kvm: x86: ioapic: Lazy update IOAPIC EOI
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "jschoenh@amazon.de" <jschoenh@amazon.de>,
        "karahmed@amazon.de" <karahmed@amazon.de>,
        "rimasluk@amazon.com" <rimasluk@amazon.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
References: <1568401242-260374-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1568401242-260374-16-git-send-email-suravee.suthikulpanit@amd.com>
 <3771e33d-365b-c214-3d40-bca67c2fa841@redhat.com>
 <5581f203-b9de-7f33-8afc-0d7026387a46@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <46754b8f-ed86-f622-0f9a-0fc1ffb2cb0c@redhat.com>
Date:   Fri, 1 Nov 2019 00:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5581f203-b9de-7f33-8afc-0d7026387a46@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/19 16:17, Suthikulpanit, Suravee wrote:
> What if we change kvm->arch.apicv_state to kvm->arch.apicv_disable_mask 
> and have each bit representing the reason for deactivating APICv.
> 
> For example:
>      #define APICV_DISABLE_MASK_IRQWIN        0
>      #define APICV_DISABLE_MASK_HYPERV        1
>      #define APICV_DISABLE_MASK_PIT_REINJ     2
>      #define APICV_DISABLE_MASK_NESTED        3
> 
> In this case, we activate APICv only if kvm->arch.apicv_disable_mask == 
> 0. This way, we can find out why APICv is deactivated on a particular VM 
> at a particular point in time.

Yes, that also works for me if it makes for an easier implementation.

Paolo
