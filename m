Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A0C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74A121670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="d/qRYpWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfGESNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:13:47 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:37550 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbfGESNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1562350426;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=TeLEUHqZcS2XHWs9Stu73yoSxS785h8O3OY1oogKKCQ=;
        b=d/qRYpWaFqeZw3rhjpieZ+DQmq9wVRn+D6yyjyKsBLpC+G1oQ8n5Hdrk2PCoN+lE
        Hs0N/jxd1qmxGuQEsOz299CAgUsjE71Ku2gRi8totodbwfUaGj8nLY5aVsnAu/F8ViW
        Yb98szIbMYFFAnIkBFuj6JkLBhrEyz7hpnu4Zo+8=
Date:   Fri, 5 Jul 2019 18:13:46 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/slab: One function call less in
 verify_redzone_free()
In-Reply-To: <c724416e-c8bc-6927-00c5-7a4c433c562f@web.de>
Message-ID: <0100016bc3579800-ee6cd00b-6f59-4d86-be0c-f63e2b137d18-000000@email.amazonses.com>
References: <c724416e-c8bc-6927-00c5-7a4c433c562f@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.07.05-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019, Markus Elfring wrote:

> Avoid an extra function call by using a ternary operator instead of
> a conditional statement for a string literal selection.

Well. I thought the compiler does that on its own? And the tenary operator
makes the code difficult to read.

