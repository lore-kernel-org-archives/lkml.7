Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BECC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EA621D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="bbjdPrav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfLTFp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:45:59 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16166 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfLTFp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:45:59 -0500
X-AuditID: 0a650161-78bff700000078a3-38-5dfc782f795d
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 64.54.30883.F287CFD5; Fri, 20 Dec 2019 15:28:47 +0800 (HKT)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1576820763; h=from:subject:to:date:message-id;
        bh=QV9puvTVlrLLAKRfYbOnQOyNST131HvS00n4L58TZc0=;
        b=bbjdPravwanJ6zzEtqEMksk1FFUWe9QSkcs0Hv0WW2iCB064+L973T1EMvG6nZRzjFelIBM8iMs
        +ygaaqXA5fHFDlGVYbAL8575PpMnt28RgTfqHDnw+/Qh2Yyjx9ZAroZyK1qdXAsN3qpD2KLD1iEfg
        a/71cQho5ftF1LJ7zbg=
Received: from hsj-OptiPlex-5060 (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Fri, 20 Dec 2019 13:46:00 +0800
Date:   Fri, 20 Dec 2019 13:45:49 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Jason Baron <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v5] lib/dynamic_debug: make better dynamic log output
Message-ID: <20191220054548.GA18312@hsj-OptiPlex-5060>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
 <20191219074735.31640-1-sjhuang@iluvatar.ai>
 <ec04aa8b-5c2a-28be-a32b-6d85a17d2f21@akamai.com>
MIME-Version: 1.0
In-Reply-To: <ec04aa8b-5c2a-28be-a32b-6d85a17d2f21@akamai.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXClcqYpqtf8SfWYNlbFYvJVw+wWcxYfJzV
        Yvb9xywWl3fNYXNg8Zh8ZAGzx5dV15g9bj1by+rxeZNcAEsUl01Kak5mWWqRvl0CV8b8t9cY
        CyayVdz59Z29gfEVSxcjJ4eEgInEwiWXGbsYuTiEBE4wStxonA+WYBbQkViw+xNbFyMHkC0t
        sfwfB0iYReAtk8TxJbUQ9d8YJZ4t2csOkVCVuD7lI5jNJqAhMffEXWYQW0RAWeLKxxusEDMj
        JJb/38IEYgsLeEpc3bMOrIZXwEzi8ZeFLBBDZzNKHFz9gw0iIShxcuYTsIM4Bewkvk++xAhi
        iwINPbDtOBPIcUICChIvVmpBPKMksWTvLCYIu1Di+8u7LBMYhWcheWcWwjuzkCxYwMi8ipG/
        ODddLzOntCyxJLFILzFzEyMk7BN3MN7ofKl3iFGAg1GJh5ej4XesEGtiWXFl7iFGCQ5mJRHe
        2x0/Y4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzCv17GiMkkJ5YkpqdmlqQWgSTZeLglGpg2nqw
        4JdLo8jyY8zhB9O+3LeqYmpMnvL5LnsY97El/VU2n7xFqgrMl3/0N/pzIVswuP4yW3NkxqpX
        JS+lc078zY/U0eEQvaFT9e/crhsZi/1d5r2yMToqNikua7vjw/RLoiJ1wtEsNpdMRWbp//29
        4WeP3+6XNwp1Qwwnh9632fBkv57KqyM56wocV3q0bGsv7qlQqGj40CXAdaTVJ3QZowrb0ZPe
        Nx8cKf+6U68n7eNywS8K+QmPJ557ZV615r1LwCqxoHcCZo7rhM+ekmvUzX8jLhCy5cj5Ur9j
        fwLaPr8/HzNx5obC2yq75n5Rut712vmyb9/f/hL3L4Xay3YoeOixtK68Y34sK7+CJU9YiaU4
        I9FQi7moOBEAJhLX/vgCAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 05:10:49PM -0500, Jason Baron wrote:
> 
> 
> On 12/19/19 2:47 AM, Huang Shijie wrote:
> > The driver strings, device name and net device name are not changed for
> > the driver's dynamic log output. But the dynamic_emit_prefix() which contains
> > the function names may change when the function names are changed.
> > 
> > So the patch makes the better dynamic log output.
> 
> Another point here is that currently the output precisely matches the
> non-dynamic debug counterpart strings if not prefix is emitted. So that
> changes with this patch. I think its nice to say that the output is the
> same as the non dynamic debug output except it may have an optional
> prefix....
okay. I will add it in the next version.

Thanks
Huang Shijie
