Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B916C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3090A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfC1TKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:10:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55887 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1TKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:10:07 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8680:2bb1:1b64:2c6c:6ec3:aa41])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2SIFwYJ3433405
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 28 Mar 2019 11:15:59 -0700
Subject: Re: [PATCH 0/1] [RFC] Secure Launch boot protocol
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        corbet@lwn.net, konrad.wilk@oracle.com, kanth.ghatraju@oracle.com,
        daniel.kiper@oracle.com, boris.ostrovsky@oracle.com,
        dpsmith@apertussolutions.com
References: <20190311150423.15979-1-ross.philipson@oracle.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <54a6bc26-584f-322a-2089-be96472e2d4f@zytor.com>
Date:   Thu, 28 Mar 2019 11:15:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190311150423.15979-1-ross.philipson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, per our conversation today, lets create a new, readonly, data structure
pointed to by a single field in setup_header, in order to preserve what little
space we have left in that structure (a whopping 24 bytes...)

The new data structure will have a header consisting of a magic number and a
length field; if we want to be really paranoid we could add a checksum/crc.

The existence of this new readonly structure will be announced by bumping the
boot protocol to 2.15.

The presence of your new boot launch capability (trenchboot) will be indicated
by a new bit in xloadflags.

I thought hard about this, and I have come to the conclusion that the new
structure is better off in the .rodata section of the compressed kernel rather
than in the setup area, for the following reasons, some of which are
theoretical and unlikely to apply anywhere in the near future, but don't
actually hurt to address right off the bat:

a. The future size of the structure would not be artificially constrained by
   the 32K hard limit on the setup area;
b. It is one less level of indirection in the build tools;
c. It adds a possibly unnecessary dependency on the setup area, which could
   possibly be awkward for some boot loaders (unlikely, but...);
d. It would allow this new structure to also carry information that might be
   useful to the decompressor for whatever reason.

	-hpa
