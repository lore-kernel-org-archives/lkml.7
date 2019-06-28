Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1CA2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mTlEBBrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfF1NA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:00:59 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:44714 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfF1NA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:00:57 -0400
Received: by mail-qk1-f176.google.com with SMTP id p144so4665812qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AjYwhnBG/Zoj32JfaQGIXi4sKK1nLhc/V+pRPXqwjX0=;
        b=mTlEBBrJSlVUpqvo7/0G83f2mzK41lO4C5JAHXSCHn6kvGH3SPSPk8+Z7ZkasRHDuE
         j7ofsaK4zPNm89xFigonz4rfE0YEhzpZydNIHc2rfVlYJuFkvS39e51q/eCDw9xTU0Xf
         xYPWjGazZZD8lSP5y9jWyQwFLr1IPnj1YkYu/2CBT81GjJNqjxr6GuEIRTntmMcX1iLV
         KAiFjL4uvyBFzq/ksPyGnBQ9LBk2PIjn6Tk2n9gWj3zLvI+860RMgHUxSTHB+L9eoD1R
         2UUnzYBJFSXu9Y/REp1mvWuiripC4woYJ6nhmT3qdEaOUOoyaySWaH0xY4tV9gLgzBp8
         zl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjYwhnBG/Zoj32JfaQGIXi4sKK1nLhc/V+pRPXqwjX0=;
        b=YSvHLvnOAnmeEVygcqSZqxPIUm/DsZTFckf/WjjrtQBqlXs5z4OkZUrqYROcJllG6A
         d+FmWQL3HnW3xQQkuDbpN3PNKB34y2UxueVnM1ZNmQZAQ082tfzl6XnLV4GXB4cc8e8p
         bkBsLtB17DhEsWEum5Y8yCAj9uaSUlJUO0+6szTJEeU3wvFNsY4oiP3bxOKqTK1YSY4O
         wiAcj9h3mnQI/ITRkSBBXLsM78IWe7rYnGZCKIzmrmOrU3gy1dPNNwuJzwEHR+Z/PmW2
         ntL+gyhcAt23x4WnaZsmbwPxGROjYdR1jaotG0yvxF6vYnQ5fKAfEZPh9FG0x59u0IXW
         hTGA==
X-Gm-Message-State: APjAAAXaF7tIH/xzpKnzCpsehyK6u8hktW11+yf65VBVOPk43CbrltSp
        IHfnyvsSLdhpxhoE3UKmxijK+FvVOAk=
X-Google-Smtp-Source: APXvYqyaKT5j9r1iBViaL1lWqd0o4YriLf++bZ6JVQGu0yYj0QOQfu8NbfSruBEAQ0Oj1abIjOBCkg==
X-Received: by 2002:a37:f505:: with SMTP id l5mr8770978qkk.235.1561726856356;
        Fri, 28 Jun 2019 06:00:56 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e18sm893339qkm.49.2019.06.28.06.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 06:00:55 -0700 (PDT)
Message-ID: <1561726853.5154.100.camel@lca.pw>
Subject: Re: power9 NUMA crash while reading debugfs imc_cmd
From:   Qian Cai <cai@lca.pw>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 09:00:53 -0400
In-Reply-To: <9c87dc72-54f8-8510-c400-1e89779cc88b@linux.vnet.ibm.com>
References: <1561670472.5154.98.camel@lca.pw>
         <87lfxms8r3.fsf@concordia.ellerman.id.au>
         <715A934D-EE3A-478B-BA77-589C539FC52D@lca.pw>
         <9c87dc72-54f8-8510-c400-1e89779cc88b@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 17:19 +0530, Anju T Sudhakar wrote:
> On 6/28/19 9:04 AM, Qian Cai wrote:
> > 
> > > On Jun 27, 2019, at 11:12 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > 
> > > Qian Cai <cai@lca.pw> writes:
> > > > Read of debugfs imc_cmd file for a memory-less node will trigger a crash
> > > > below
> > > > on this power9 machine which has the following NUMA layout.
> > > 
> > > What type of machine is it?
> > 
> > description: PowerNV
> > product: 8335-GTH (ibm,witherspoon)
> > vendor: IBM
> > width: 64 bits
> > capabilities: smp powernv opal
> 
> 
> Hi Qian Cai,
> 
> Could you please try with this patch: 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-June/192803.html
> 
> and see if the issue is resolved?

It works fine.

Just feel a bit silly that a node without CPU and memory is still online by
default during boot at the first place on powerpc, but that is probably a
different issue. For example,

# numactl -H
available: 6 nodes (0,8,252-255)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52
53 54 55 56 57 58 59 60 61 62 63
node 0 size: 126801 MB
node 0 free: 123199 MB
node 8 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85
86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108
109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
node 8 size: 130811 MB
node 8 free: 128436 MB
node 252 cpus:
node 252 size: 0 MB
node 252 free: 0 MB
node 253 cpus:
node 253 size: 0 MB
node 253 free: 0 MB
node 254 cpus:
node 254 size: 0 MB
node 254 free: 0 MB
node 255 cpus:
node 255 size: 0 MB
node 255 free: 0 MB
node distances:
node   0   8  252  253  254  255 
  0:  10  40  80  80  80  80 
  8:  40  10  80  80  80  80 
 252:  80  80  10  80  80  80 
 253:  80  80  80  10  80  80 
 254:  80  80  80  80  10  80 
 255:  80  80  80  80  80  10 

# cat /sys/devices/system/node/online 
0,8,252-255



