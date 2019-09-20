Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1087C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7166D207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="hP5K+LGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437815AbfITIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:41:27 -0400
Received: from plaes.org ([188.166.43.21]:56356 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437766AbfITIl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:41:27 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Sep 2019 04:41:26 EDT
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id 4ED0A401A2;
        Fri, 20 Sep 2019 08:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1568968358; bh=B88eQXvMcqPCljBCgykzFFLBC6ki+6QWIgs8CmMzNSc=;
        h=Date:From:To:Cc:Subject:From;
        b=hP5K+LGolyuLvkyMObHkPDJI+3SO5aqs2BkePcyR3N8tnNSGB3eem7s8Ay08w9saL
         2vdVZbGw9haNc1RLljjA7cyr5LjLxYLZHPgK3IvhnNQgvjByHZqpy4OKjHro5lC5FE
         ydiX6NoQqtkd97+MqM8DPBPabL2+0lBAL3sFYO3qWa4VnLsLYRigwi400a/IAFLfJL
         EPzWkE2zEUi4vJ6B8LviMqM2oMwWVVYGiwMlTvC+Fehc1aHUHCVGqY+yn4MXM3IZT9
         PBF3avKVDYYgVmEcNNgEGVGvpI5m/4gMCupSoKyE4BhuObRcLr42AKaDwklSPoLoYf
         37EmmfpP3SBcw==
Date:   Fri, 20 Sep 2019 08:32:37 +0000
From:   Priit Laes <plaes@plaes.org>
To:     mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, priit.laes@paf.com
Subject: [BUG] sun4i: axp209: no atomic i2c transfer handler
Message-ID: <20190920083237.GA11657@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heya!

I have seen following warning message for few times when shutting down the
machine (Olinuxino Lime2-emmc) running the mainline kernel.

[snip]
WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:41 i2c_transfer+0xe8/0xf4
No atomic I2C transfer handler for 'i2c-1'
Modules linked in: enc28j60
CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.3.0-rc8-paf+ #28
Hardware name: Allwinner sun7i (A20) Family
[<c010ee08>] (unwind_backtrace) from [<c010b5b8>] (show_stack+0x10/0x14)
[<c010b5b8>] (show_stack) from [<c06bf2b4>] (dump_stack+0x88/0x9c)
[<c06bf2b4>] (dump_stack) from [<c011e044>] (__warn+0xd4/0xf0)
[<c011e044>] (__warn) from [<c011dbe4>] (warn_slowpath_fmt+0x48/0x6c)
[<c011dbe4>] (warn_slowpath_fmt) from [<c051ce20>] (i2c_transfer+0xe8/0xf4)
[<c051ce20>] (i2c_transfer) from [<c051ce78>] (i2c_transfer_buffer_flags+0x4c/0x70)
[<c051ce78>] (i2c_transfer_buffer_flags) from [<c046c2a4>] (regmap_i2c_write+0x14/0x30)
[<c046c2a4>] (regmap_i2c_write) from [<c0468180>] (_regmap_raw_write_impl+0x588/0x63c)
[<c0468180>] (_regmap_raw_write_impl) from [<c0468b50>] (regmap_write+0x3c/0x5c)
[<c0468b50>] (regmap_write) from [<c046f554>] (axp20x_power_off+0x2c/0x38)
[<c046f554>] (axp20x_power_off) from [<c013e8a4>] (sys_reboot+0x14c/0x1e0)
[<c013e8a4>] (sys_reboot) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xef04ffa8 to 0xef04fff0)
ffa0:                   00427954 00000000 fee1dead 28121969 4321fedc 16814300
ffc0: 00427954 00000000 00000000 00000058 bec15c78 00000000 bec15c10 004266f8
ffe0: 00000058 bec15b6c b6f69d45 b6eeb746
[/snip]

The enc28j60 module is SPI, so it has nothing to do with the message.

Any ideas where to look?

Päikest,
Priit :)
