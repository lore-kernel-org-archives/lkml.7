Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE42C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0446D216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MH3wkoDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfF0Abo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:31:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36937 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfF0Abj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:31:39 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so864411iok.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ne57qfOBbrpWTmSwKmjlTjKmsCo+Sn2qKc5QwP4b3qo=;
        b=MH3wkoDXHfXF5fF0q+4ozL7+zgvn5SeiKtLiHYzCNIcqFHXPkPAwLMDAdDzk2aiIwQ
         J78PjhZZ31NuKv8zy1/s8y3MRPBSFAVisSCw3pC/YBe5ea4C6Y+uFm5wHpal8nsxZLgB
         17lsiKG0OIZo1/fcOW8X2bMD/PSdyDvCVff3iu2G8wmtMH1QHqrOcCB6eOgDt4VuNjyk
         Poo9nGwiL6andopg9rnVNY+S336HW1WgpryVcFd4HvLr9UhpPKVIrzsbJAzaKITb3fvh
         sahpopsxSkGUr9VegYM/UOtFcnxFerQwnrKs330QIqOEtyCvWxY78rUw69KxygSiqpv1
         hjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ne57qfOBbrpWTmSwKmjlTjKmsCo+Sn2qKc5QwP4b3qo=;
        b=t6Re5+X86nR0LgzHr4bHd8GCRuPBlFKmfFTA1OcpLGqlHdHwOAl8TBNGipmBqYll/C
         CzQsV2wh4ncYDqTibmDMsQJeLa4U/dTc2yOPA/Nx2b/YRcICo8hLDpPnaUSq8RwJ3+PN
         5xay0CyJTAnyCglWJgwaO/d2Ba95Wi4snXSS3ctKvRAVp2C2csFQYOb9sV6IV1jMwyHa
         jQnMdV9kwCJZxIO/iGECB1sOY0EbCmQakXQVLU70fc3uVpy/KGNx9rrC8T7WxyPickDs
         ybUUjfPF5G3RQ4kl2bkJNC79phdYgDPOkMiN+4bCD3CLn92TxA/AZK35QaKikV8m6Kjw
         kHzw==
X-Gm-Message-State: APjAAAUVyAeGB06p24M6obOiIV+RjuxxjjpfhRV/lt/t8StDZQ3a2LPe
        n0nhuFQJ+jl5gzndRR87CWgXUQ==
X-Google-Smtp-Source: APXvYqzkfD/79362o4UBWtnH1yN59+5ocrB6dWn1PQrF9lxmChizX5AwqLnfXA+vMES0ciXEXr5ebA==
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr1187601iob.271.1561595498768;
        Wed, 26 Jun 2019 17:31:38 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id n26sm410757ioc.74.2019.06.26.17.31.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 17:31:38 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:31:37 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
In-Reply-To: <20190617185920.29581-2-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906261724000.23534@viisi.sifive.com>
References: <20190617185920.29581-1-atish.patra@wdc.com> <20190617185920.29581-2-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, Atish,

On Mon, 17 Jun 2019, Atish Patra wrote:

> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> The current ARM DT topology description provides the operating system
> with a topological view of the system that is based on leaf nodes
> representing either cores or threads (in an SMT system) and a
> hierarchical set of cluster nodes that creates a hierarchical topology
> view of how those cores and threads are grouped.
> 
> However this hierarchical representation of clusters does not allow to
> describe what topology level actually represents the physical package or
> the socket boundary, which is a key piece of information to be used by
> an operating system to optimize resource allocation and scheduling.
> 
> Lets add a new "socket" node type in the cpu-map node to describe the
> same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This one doesn't apply cleanly here on top of v5.2-rc2, Linus's master 
branch, and next-20190626.  The reject file is below.  Am I missing 
a patch?


- Paul

--- Documentation/devicetree/bindings/arm/topology.txt
+++ Documentation/devicetree/bindings/arm/topology.txt
@@ -185,13 +206,15 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
 4 - Example dts
 ===========================================
 
-Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
+Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters in a single
+physical socket):
 
 cpus {
 	#size-cells = <0>;
 	#address-cells = <2>;
 
 	cpu-map {
+		socket0 {
 			cluster0 {
 				cluster0 {
 					core0 {
