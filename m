Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB144C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD77621743
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NDgI8+6C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FQuv3ev3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfEQSD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:03:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60836 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfEQSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:03:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6CC8660709; Fri, 17 May 2019 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558116206;
        bh=IbnAGN0DIJaVE08Oe3a19rRp+gftn7Ija/z3WCGwkO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NDgI8+6CYqnF8diJemuqlcWXw/rstDhr6EhAJpNjtQViz20zqZfb/HRBA409/ptji
         BK9U78AP6MF65458eeJ2yCLPVSqmi/icnfLP3rfEaBTRLoB+toygC420X2ylZmKUIn
         quFWas97jXQ2y5CfxNmqUzpL9byhGtv9hgbqwL2Y=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CA38F60709;
        Fri, 17 May 2019 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558116205;
        bh=IbnAGN0DIJaVE08Oe3a19rRp+gftn7Ija/z3WCGwkO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FQuv3ev3EX9qWa2YCFlsJLLzSG2NzmK3M4Bqbi5/hsQe6ONxTcLSituDiE5n7nNb0
         n/d7lWdlwjS0dTCJla9dRqo+2otFs7mN92+PUVBuYjQgl5IwvVKNOZ40uE2tHJkPnH
         PjGQOez5db7UBgcDNXJXLUC8eahmjBe6eHaz1h1Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 May 2019 11:03:25 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     sudeep.holla@arm.com, julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kernel/panic: Use SYSTEM_RESET2 command for warm reset
In-Reply-To: <20190516182949.GD10985@darkstar.musicnaut.iki.fi>
References: <ce0b66f5d00e760f87ddeeacbc40b956@codeaurora.org>
 <1557366432-352469-1-git-send-email-psodagud@codeaurora.org>
 <20190516182949.GD10985@darkstar.musicnaut.iki.fi>
Message-ID: <caa4ee48af33b320d8a1bcdbb974ada8@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-16 11:29, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, May 08, 2019 at 06:47:12PM -0700, Prasad Sodagudi wrote:
>> Some platforms may need warm reboot support when kernel crashed
>> for post mortem analysis instead of cold reboot. So use config
>> CONFIG_WARM_REBOOT_ON_PANIC and SYSTEM_RESET2 psci command
>> support for warm reset.
> 
> Please see commit b287a25a7148 - you can now use kernel command
> line option reboot=panic_warm to get this.

Thanks Aaro. Yes. I can use this option.  Thanks Sudeep and all for 
discussing.

> 
> A.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
