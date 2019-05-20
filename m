Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F88C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ACC20862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfETLUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:20:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfETLUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:20:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so14099405wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f4Ug1MrEqipFcsXWDEaXY+h36JBhOVj9TAD4XBLpsmg=;
        b=cJEnWMABzNodR6o9Nmt7LtUrCXwZSPgerlh65uflgeEAKWjxY7LS1RKSWm/FUvnIXy
         6BRb5xtTTUYaW94VwT9mB7FfAASVq2Xs7VrGD5joY7Gd2uHYk9Sg4PHIZrYvNFegHKVN
         CzkBie1pJc09tYAKgikZz87y4wzHL70GDvgy5NVJLTiIXr2KahQWJSZz1jWwzM5PSnDh
         y7ftaaJKA5jpyAAWTRFB0zhdSPO9sjcchBMGkreBm1k/mhFbZ9cenQn2/W1zCGq7ih4n
         gV8/WHuu4guhzp2exV6bwISFnH1pb+rIBunxoLGyTdmbHMoSitaI6snBYtG/C3RN1Gyb
         PdtQ==
X-Gm-Message-State: APjAAAVJveKtGxsb/WpJn6tQBgy5LDj546+/UU8XDIbDfDjdsAuvbTeb
        k76BDzMDhoe1aqF9QKYQ3EHwCg==
X-Google-Smtp-Source: APXvYqythDnG05R24/GCVku939OLV2V+hp8o445FMzheQB00gWCVpDRQZJzknTi/GPq603//Mn3fFg==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr34566267wrt.96.1558351204927;
        Mon, 20 May 2019 04:20:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id e2sm12948704wme.32.2019.05.20.04.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:20:04 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] KVM selftests for s390x
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20190516111253.4494-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b412e591-3983-ebef-510b-43f9b7be4147@redhat.com>
Date:   Mon, 20 May 2019 13:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516111253.4494-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/19 13:12, Thomas Huth wrote:
> This patch series enables the KVM selftests for s390x. As a first
> test, the sync_regs from x86 has been adapted to s390x.
> 
> Please note that the ucall() interface is not used yet - since
> s390x neither has PIO nor MMIO, this needs some more work first
> before it becomes usable (we likely should use a DIAG hypercall
> here, which is what the sync_reg test is currently using, too...).

No objections at all, though it would be like to have ucall plumbed in
from the beginning.

Paolo
