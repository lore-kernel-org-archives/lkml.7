Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A349C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218D4206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="d3ikbxSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCJQ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:56:34 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:53979 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfCJQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:56:33 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 118CE20BE0;
        Sun, 10 Mar 2019 19:56:30 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 3HzfXTSiZ4-uTc48pPW;
        Sun, 10 Mar 2019 19:56:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552236990; bh=/sJg9VkFzNt0ZgJPEiBkEp13j44MSyLlHoYJbOuJK1g=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=d3ikbxSPOi1YBcRiA2vm8kkPcW1ekJGFAmktRg7AdPD0V5JG7hRghraxtqSr35Xk9
         ++xIU60wa2x6bYoXZFU0wwdsENnFSxz4h5tzSORbUld1JFWfFaqy9wslxXFNWKRU8u
         ceVUYErwTHGIj6gXfa5V2kK2MH7c4TNAULZHyaGg=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:35])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id K9GFzVxXGE-uTDektN0;
        Sun, 10 Mar 2019 19:56:29 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 0/6] Make sscanf safer
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 10 Mar 2019 19:56:29 +0300
Message-ID: <155223448227.4075.6846910559654700796.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard sscanf isn't well designed for input validation:

 * no way to detect interger overflow
 * unmached tail text is ignored
 * no mandatory buffer overflow checks

All these problems were found in the wild in cgroup interfaces:
https://patchwork.kernel.org/patch/10831387/
https://lore.kernel.org/patchwork/patch/1046130/

This patchset has patches for first two issues.
Unbounded "%s" is out of scope for now.

Second patch handles integer overlow as parse error:
sscanf exits without touching related argument.

Third patch adds convenient way for checking that
whole text was matched and nothing left.

Fourth adds missing standard features for %[...],
this might be useful for input validation.

Fifth adds __must_check and will generate some new warnings.

The last is a simple test module for chechking some basic and
new corner-cases added by this patchset.


Code haven't chaneged much:

$ ./scripts/bloat-o-meter lib/vsprintf.o.old lib/vsprintf.o.new
add/remove: 0/0 grow/shrink: 1/0 up/down: 60/0 (60)
Function                                     old     new   delta
vsscanf                                     2270    2330     +60
Total: Before=16904, After=16964, chg +0.35%


Unbounded "%s" could be fixed only by making field width mandatory.
There are only few users and in most cases sscanf could be eliminated.


---

Konstantin Khlebnikov (6):
      lib: scanf: document features of scanf format string
      lib: scanf: handle integer overflows in vsscanf
      lib: scanf: add vsscanf feature for matching end of text
      lib: scanf: handle character ranges in %[...]
      lib: scanf: mark sscanf and vsscanf as __must_check
      lib: scanf: add test module


 include/linux/kernel.h |   10 ++
 lib/Kconfig.debug      |    3 +
 lib/Makefile           |    1 
 lib/test_scanf.c       |  252 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/vsprintf.c         |  153 +++++++++++++++++++++--------
 5 files changed, 376 insertions(+), 43 deletions(-)
 create mode 100644 lib/test_scanf.c

--
Signature
