Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847F1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72C218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfJTTC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 15:02:56 -0400
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:53540 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbfJTTC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:02:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id ABBD6100E7B42;
        Sun, 20 Oct 2019 19:02:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: level02_194bc56e7ad54
X-Filterd-Recvd-Size: 2682
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 19:02:53 +0000 (UTC)
Message-ID: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
Subject: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 20 Oct 2019 12:02:52 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an argument inconsistency between these 4 functions
in include/linux/byteorder/generic.h

It'd be more a consistent API with one form and not two.

   static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
   {
   	while (words--) {
   		__le32_to_cpus(buf);
   		buf++;
   	}
   }

   static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
   {
   	while (words--) {
   		__cpu_to_le32s(buf);
   		buf++;
   	}
   }

vs

   static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
   {
   	int i;

   	for (i = 0; i < len; i++)
   		dst[i] = cpu_to_be32(src[i]);
   }

   static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t len)
   {
   	int i;

   	for (i = 0; i < len; i++)
   		dst[i] = be32_to_cpu(src[i]);
   }

Added via 2 different commits:

commit f2f2efb807d339513199b1bb771806c90cce83ae
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Mon Oct 2 13:38:28 2017 +0300

    byteorder: Move {cpu_to_be32, be32_to_cpu}_array() from Thunderbolt to core
    
    We will be using these when communicating XDomain discovery protocol
    over Thunderbolt link but they might be useful for other drivers as
    well.
    
    Make them available through byteorder/generic.h.
    
    Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

and

commit 9def051018c08e65c532822749e857eb4b2e12e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed Mar 21 19:01:40 2018 +0200

    crypto: Deduplicate le32_to_cpu_array() and cpu_to_le32_array()
    
    Deduplicate le32_to_cpu_array() and cpu_to_le32_array() by moving them
    to the generic header.
    
    No functional change implied.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

