Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED9C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565B7206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576859686;
	bh=vv0t1eGOsgj4AJRjK2Vg7hvSuEzjKLFQEXcZQpwhYK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qm18T6RCkD1B0PlqNr4GQ/JnOOZV23HgOSPqBNwwV2MJVJgflXQFV/GvcmWzXg2PP
	 3VW4F5E59BZQP04TKbollZwabsqu+6TLnrvMIyl/8LbhqWHunHgvCWQmCP4Y23SaBY
	 l/1HjOeadoZAvX52VXbC7xm3985WL4SW3Jun/kSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLTQep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:34:45 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:45902 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTQeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:34:44 -0500
Received: by mail-qt1-f176.google.com with SMTP id l12so8645831qtq.12;
        Fri, 20 Dec 2019 08:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2wiG4V9nXDcYp93nFV8wxg+pKyytXlurRJn0olF8cc=;
        b=mEbQsjqJ1j16fUpahYOimus1B1lnXLMQnQLpFURegX8v17kvx4s6H+uyrHvLcriQav
         2lEpXor9io+tIVsXk8R0U2mbpNkNgMau9xFmqOycHTIItkTdYgUzzcOUzYXovW4nRvMk
         nKiT2Kq7R/hWzTH22vxLdKvCyzF/3WCFjHjOmgOm6oflj4gY9oDtpQe0/LIuzM/KjXSd
         QcaPnUUNDaZtR5palhizK4VrANl7sPB3suRw2PUu/vJdDUKcVMoP6wqDP5goo6mmImxR
         PDLu11WprAKnGdVb/skReG0K3eSPOFO70nWhNdDkHrq5nY+potj3utsjOyqlg4tjhbAT
         hMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2wiG4V9nXDcYp93nFV8wxg+pKyytXlurRJn0olF8cc=;
        b=XeVGYr9onpf8sCYIdliI1b6YMhnMZICWXf+lkZjsY6tX6afPBhj/eWMkVBNgPTp0v4
         S7TRK21tXeBjKz4n+frY9mL+gpIKKLtoZ3x5SgL0VA+x6Kv/kbr5R0xwmL9RqisK55jQ
         36FdcIJ9DRzOlGsB+fk14HCLAypZTXGKV9pgO+tPFY6ouML3kSACPCFBYHD2fAJLPaVm
         YzYA0OP+C+0uGL2vM/P/AFMZAaLh8ql53Lg4diFiOl+KA5XW30x4Rbq2jyT9Zi2hR8VV
         +BbjYtXDM9zTEpX7fC9d1Uj1weUjKpSsZ9Jd4fpy5Dp2qjxysTWZ9YK+MII6EibCywtt
         JiYQ==
X-Gm-Message-State: APjAAAV1FPMCx1hV7HnbAw18RJkWlfOiSHkH+6lTf4byG+NHErzToV5F
        7Sn0zpZSEfoKO85aP1KvUAEw5nawChc=
X-Google-Smtp-Source: APXvYqxdTmROGq8u9t4V757dBQhddzRsHPWWCpr8nAsfRAHDN4P5YIulIFC17B7dIk8wXNeH2wR1dA==
X-Received: by 2002:ac8:664a:: with SMTP id j10mr12215392qtp.70.1576859683642;
        Fri, 20 Dec 2019 08:34:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::11e7])
        by smtp.gmail.com with ESMTPSA id x126sm2955357qkc.42.2019.12.20.08.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 08:34:43 -0800 (PST)
Date:   Fri, 20 Dec 2019 08:34:41 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: Percpu variables, benchmarking, and performance weirdness
Message-ID: <20191220163441.GH2914998@devbig004.ftw2.facebook.com>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
 <20191220103420.6f9304ab@carbon>
 <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
 <a66e79b1-41a8-08f6-8dc2-37ce7a5fff53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66e79b1-41a8-08f6-8dc2-37ce7a5fff53@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 08:22:02AM -0800, Eric Dumazet wrote:
> I definitely seen expensive per-cpu updates in the stack.
> (SNMP counters, or per-cpu stats for packets/bytes counters)
> 
> It might be nice to have an option to use 2M pages.
> 
> (I recall sending some patches in the past about using high-order pages for vmalloc,
> but this went nowhere)

Yeah, the percpu allocator implementation is half-way prepared for
that.  There just hasn't been a real need for that yet.  If this
actually is a difference coming from tlb pressure, this might be it, I
guess?

Thanks.

-- 
tejun
