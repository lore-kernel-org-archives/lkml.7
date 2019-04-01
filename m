Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE16C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E301208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="iehmVfyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfDAQyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:54:04 -0400
Received: from one.firstfloor.org ([193.170.194.197]:45180 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfDAQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:54:04 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 569C486747; Mon,  1 Apr 2019 18:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1554137641;
        bh=ITGWjoWeqgKZo/1D1ax7ML9QzsLSE9g5zeWtbX5kGlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iehmVfyNIq5G8Hk6uN400Gc7790dfjCEndqUxzzExjFSj2QZTWTXafQr8O9lutxSr
         UHksP3zpnNNnXSZgxOu5BVHBJAiOMbKn0IvHKD9By7UZupPFGWmAJAI32+CSt63alN
         sRos7Ift8zxS42HLGD9++BUpZma9lInYysDHaIOE=
Date:   Mon, 1 Apr 2019 09:54:01 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Hugues FRUCHET <hugues.fruchet@st.com>
Cc:     Andi Kleen <andi@firstfloor.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "mchehab@s-opensource.com" <mchehab@s-opensource.com>
Subject: Re: [PATCH 10/17] delta: Fix buffer overrun in delta_ipc_open
Message-ID: <20190401165400.pdp547zqwdojz67r@two.firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-11-andi@firstfloor.org>
 <bb7d9aeb-9cde-92c6-cbd1-c0ba3d283f07@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7d9aeb-9cde-92c6-cbd1-c0ba3d283f07@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:37:56PM +0000, Hugues FRUCHET wrote:
> Hi Andi,
> 
> We have already discussed about that here:
> https://lore.kernel.org/patchwork/patch/866406/
> 
> Now that strscpy is largely deployed within kernel, could you retest 
> with the change I suggested ?

strscpy is not the correct fix because it leaks uninitialized memory
to the receiver.  You need the memset.

-Andi
