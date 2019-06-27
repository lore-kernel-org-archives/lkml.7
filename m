Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8CFC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A348621726
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VyopmJiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfF0CSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:18:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33003 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfF0CSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561601918; x=1593137918;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Tfwp7gFaZ6qND8kZaF7KWkT1wyf1zxCP1c9dIpITNvc=;
  b=VyopmJiJ2dTyiLq1F0/B5SezS3UXRMLoYs1s/dm5lEOxLIw73Qt1bP4C
   Qlwe7BKPRKFDYR0TEGTMw7r5w+/GcwzTfLt4jF19PPf3s8Bzeu1JRhlHJ
   5toKFkDJqJxt2KgRssbbtdBFxitGik3DxTkMhtTJGbFigXYyRZfmK+6P6
   udKcVIDIHDR02KTUBcmi+O+wAbBUWnGRZHmqbChkAnCEpYW5S3ww1ynC5
   S577drFVcRrHh54vemkEycct/irWA5MSA9qHJ6n06H/Ebkl/DPmRYjNLj
   SA3mIBjf4UrCfEP8YDeMcArDEKLJm2hKp7nuZQ9tzdKzTQBq/z2gulyzz
   A==;
X-IronPort-AV: E=Sophos;i="5.63,422,1557158400"; 
   d="scan'208";a="218020175"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 10:18:38 +0800
IronPort-SDR: Etgl/ZFsNqgFjy1k+Q6uALRkqorriwzWpOEiL33wGew0nGkUmQi02F/zmmPqagcdO4KqGMkmV2
 xx6F10y/WU1VG0EO+vClyYAYe7XN9Cy+J/HeP71XyUCu1oBEvPzC5hkuXKOUak5SGRKgH2Ygce
 tUyzpOpby3nda6HqhdYWaMApiKxlWxCP8wsSHbJ75jVFOBRllkCW+21pBUFVHKGINyUEXMHagX
 /IYAyypUk1zJdeJH+50tZgnAI08r8UbrclMnrgugF779VKoJ530NQN6KzGVbXVwKRWyPUc36Fp
 eW54F9wUMk4GEUt1KD6qG+ah
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2019 19:17:46 -0700
IronPort-SDR: ciLexNHCv6HL8MZuckFUeBuAAqxAHwDwL0T3akazDuuvQlT+UmUai8SZlQcgLlMo31DzQYCy9C
 hUmWFABApl4vhwrHwwwNgApIeFL7zgMAQsNfesmsMzYlcHY/bExk7+MCe6LFtwJP5mf9NcCS5I
 yosY85vqe7YCnHakfyQMwyQjzZEz/2iJf1D2qk2ScLEpepDs50z5eYX5Yas7bf4/E5rwInY8df
 VA2fHixn7pD+aJT3u6PzOm755RWHxstUQ+JkAIqkjoIGczFDwhyJa85Jy2zwmAziFv0/Njm1rR
 +rY=
Received: from usa005100.ad.shared (HELO [10.225.99.96]) ([10.225.99.96])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2019 19:18:37 -0700
Subject: Re: [PATCH v7 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
References: <20190617185920.29581-1-atish.patra@wdc.com>
 <20190617185920.29581-2-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1906261724000.23534@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <873a80f0-e704-dd7e-4db9-b159b23847fc@wdc.com>
Date:   Wed, 26 Jun 2019 19:18:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1906261724000.23534@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 5:31 PM, Paul Walmsley wrote:
> Hi Sudeep, Atish,
> 
> On Mon, 17 Jun 2019, Atish Patra wrote:
> 
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> The current ARM DT topology description provides the operating system
>> with a topological view of the system that is based on leaf nodes
>> representing either cores or threads (in an SMT system) and a
>> hierarchical set of cluster nodes that creates a hierarchical topology
>> view of how those cores and threads are grouped.
>>
>> However this hierarchical representation of clusters does not allow to
>> describe what topology level actually represents the physical package or
>> the socket boundary, which is a key piece of information to be used by
>> an operating system to optimize resource allocation and scheduling.
>>
>> Lets add a new "socket" node type in the cpu-map node to describe the
>> same.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> This one doesn't apply cleanly here on top of v5.2-rc2, Linus's master
> branch, and next-20190626.  The reject file is below.  Am I missing
> a patch?
> 

That's weird. I could apply the patch from any git tree (github or 
git.kernel.org) but not from mail or patchworks.

git log doesn't show any recent modifications of that file. I am trying 
to figure out what's wrong.
> 
> - Paul
> 
> --- Documentation/devicetree/bindings/arm/topology.txt
> +++ Documentation/devicetree/bindings/arm/topology.txt
> @@ -185,13 +206,15 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
>   4 - Example dts
>   ===========================================
>   
> -Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
> +Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters in a single
> +physical socket):
>   
>   cpus {
>   	#size-cells = <0>;
>   	#address-cells = <2>;
>   
>   	cpu-map {
> +		socket0 {
>   			cluster0 {
>   				cluster0 {
>   					core0 {
> 


-- 
Regards,
Atish
