Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D02C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B4C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="VlBq3Pjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCDUaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:30:21 -0500
Received: from mx1.cock.li ([185.10.68.5]:36859 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbfCDUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:30:20 -0500
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 15:30:18 EST
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1551730886; bh=W2PpgaMOfx4TnceHjzHLfJSHMtffmmBXJ0QXAn8AFY8=;
        h=Date:From:To:Cc:Subject:From;
        b=VlBq3PjvmbVvA8fcDfU34BmV9N4YbCG2tebAuedVam0qfz8fOjNUcffz8R8oDGOdv
         kj1a+P3dMMh/3vvXIZdt/tuEI9YNyV97DstK4ax4FkuTlXoS9I+O2z+5KazMVBEGvc
         EiTU0lmeAKEOJX9hNldXIYI5VTys8NCLHitFPdeHncirEJTPAztEi1apEjXAcorbFw
         YV8KWZTej4ljKsZzAKf3GDVXvJ395w0N/oWqqg7P+c+NNI0nOje7hqe8yfWuuHM9fW
         9VW8fK++Q7txCY8EdfsxjKpntL4asfP5QRCBTl40APKff/lO4+R9krXSufUMyHaMsE
         CLMv457xyKOpA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Mar 2019 15:21:26 -0500
From:   e1000nic@firemail.cc
To:     e1000-devel@lists.sf.net
Cc:     linux-kernel@vger.kernel.org
Subject: Intel Pro 1000MT Dual Port nic. Need eeprom dump from working card
 via ethtool. It ff ff ff...d out it's EEPROM, but I got one port working after
 a day... but not the second.
Message-ID: <88ff0855d1e7de04fcbbaec6ca56a577@firemail.cc>
X-Sender: e1000nic@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

does anyone have a intel Pro 1000MT Dual port gigabit card they could 
give an eeprom dump of (via ethtool -e eth1 ), I now have one port 
working but the other is not, the eeprom someone posted seems to be only 
for the 1st port


I need help with an intel dual port gigabit nic. It' zeroed out it's 
eprom (well... 1'd it out) and thus I had to reload the eeprom

the dump someone posted seems to be only for the single port card tho, 
and the 2nd port is inactive (it worked yesterday before the 
self-bricking)
(That has been hugely helpful however)

The magic number for the intel PRO 1000MT is:
0x10798086




The offset file worked for one port, but not the other.

[code]
Offset		Values
------		------
0x0000		00 04 23 cb 27 cc 10 02 ff ff ff ff ff ff ff ff
0x0010		84 a7 07 08 0a 66 2e 00 86 80 00 61 4e 00 20 b2
0x0020		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0030		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0040		cf 00 61 78 0b 28 00 00 c8 04 ff ff ff ff ff ff
0x0050		ff ff ff ff ff ff ff ff ff ff ff ff ff ff 02 06
0x0060		2c 01 00 40 1f 12 ff ff ff ff ff ff ff ff ff ff
0x0070		ff ff ff ff ff ff ff ff ff ff ff ff ff fe 24 31
[/code]

These commands got 1 port of the intel Pro 1000MT Dual Port working:
[code]
ethtool -E eth1 magic 0x10798086 offset 0x0 value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x1 value 0x04
ethtool -E eth1 magic 0x10798086 offset 0x2 value 0x23
ethtool -E eth1 magic 0x10798086 offset 0x3 value 0xcb
ethtool -E eth1 magic 0x10798086 offset 0x4 value 0x27
ethtool -E eth1 magic 0x10798086 offset 0x5 value 0xcc
ethtool -E eth1 magic 0x10798086 offset 0x6 value 0x10
ethtool -E eth1 magic 0x10798086 offset 0x7 value 0x02
ethtool -E eth1 magic 0x10798086 offset 0x8 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x9 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0xa value 0xff
ethtool -E eth1 magic 0x10798086 offset 0xb value 0xff
ethtool -E eth1 magic 0x10798086 offset 0xc value 0xff
ethtool -E eth1 magic 0x10798086 offset 0xd value 0xff
ethtool -E eth1 magic 0x10798086 offset 0xe value 0xff
ethtool -E eth1 magic 0x10798086 offset 0xf value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x10 value 0x84
ethtool -E eth1 magic 0x10798086 offset 0x11 value 0xa7
ethtool -E eth1 magic 0x10798086 offset 0x12 value 0x07
ethtool -E eth1 magic 0x10798086 offset 0x13 value 0x08
ethtool -E eth1 magic 0x10798086 offset 0x14 value 0x0a
ethtool -E eth1 magic 0x10798086 offset 0x15 value 0x66
ethtool -E eth1 magic 0x10798086 offset 0x16 value 0x2e
ethtool -E eth1 magic 0x10798086 offset 0x17 value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x18 value 0x86
ethtool -E eth1 magic 0x10798086 offset 0x19 value 0x80
ethtool -E eth1 magic 0x10798086 offset 0x1a value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x1b value 0x61
ethtool -E eth1 magic 0x10798086 offset 0x1c value 0x4e
ethtool -E eth1 magic 0x10798086 offset 0x1d value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x1e value 0x20
ethtool -E eth1 magic 0x10798086 offset 0x1f value 0xb2
ethtool -E eth1 magic 0x10798086 offset 0x20 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x21 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x22 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x23 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x24 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x25 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x26 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x27 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x28 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x29 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x2a value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x2b value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x2c value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x2d value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x2e value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x2f value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x30 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x31 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x32 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x33 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x34 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x35 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x36 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x37 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x38 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x39 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x3a value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x3b value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x3c value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x3d value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x3e value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x3f value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x40 value 0xcf
ethtool -E eth1 magic 0x10798086 offset 0x41 value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x42 value 0x61
ethtool -E eth1 magic 0x10798086 offset 0x43 value 0x78
ethtool -E eth1 magic 0x10798086 offset 0x44 value 0x0b
ethtool -E eth1 magic 0x10798086 offset 0x45 value 0x28
ethtool -E eth1 magic 0x10798086 offset 0x46 value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x47 value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x48 value 0xc8
ethtool -E eth1 magic 0x10798086 offset 0x49 value 0x04
ethtool -E eth1 magic 0x10798086 offset 0x4a value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x4b value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x4c value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x4d value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x4e value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x4f value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x50 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x51 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x52 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x53 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x54 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x55 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x56 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x57 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x58 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x59 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x5a value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x5b value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x5c value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x5d value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x5e value 0x02
ethtool -E eth1 magic 0x10798086 offset 0x5f value 0x06
ethtool -E eth1 magic 0x10798086 offset 0x60 value 0x2c
ethtool -E eth1 magic 0x10798086 offset 0x61 value 0x01
ethtool -E eth1 magic 0x10798086 offset 0x62 value 0x00
ethtool -E eth1 magic 0x10798086 offset 0x63 value 0x40
ethtool -E eth1 magic 0x10798086 offset 0x64 value 0x1f
ethtool -E eth1 magic 0x10798086 offset 0x65 value 0x12
ethtool -E eth1 magic 0x10798086 offset 0x66 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x67 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x68 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x69 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x6a value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x6b value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x6c value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x6d value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x6e value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x6f value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x70 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x71 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x72 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x73 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x74 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x75 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x76 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x77 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x78 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x79 value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x7a value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x7b value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x7c value 0xff
ethtool -E eth1 magic 0x10798086 offset 0x7d value 0xfe
ethtool -E eth1 magic 0x10798086 offset 0x7e value 0x24
ethtool -E eth1 magic 0x10798086 offset 0x7f value 0x31

[/code]
