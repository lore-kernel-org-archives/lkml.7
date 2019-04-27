Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C47C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A08206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZwQgviwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfD0Sjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:39:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41856 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfD0Sjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:39:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so3149492pgs.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nEhuJO1Ynor4weZ/NdgsrjcDQwLHIYNiPIAmRLX4GUE=;
        b=ZwQgviwGd+jrVmG8JFn7bjaIAV2TsrvxU4gwqb0RDG2b2a6/tuGS1bjSPD5zFcQiMZ
         OmpdIgRQkfd1VLQyOhHZ2sy7TIKkdUPmLR3gYx0vHzrPUF+3LdpG+0aUq9NHLigzxuLt
         w9kpljzekW+UpvNnGxUjjZ2Bx9bD32Ndbifx8VInBOuMS2iEobHHMQQB1VrB954vWtp/
         Nrbgy+r1/XJ21U/lWl3YVsMz6ktPb/ZCQWFwdDqE83Lw5y4t5RaboQA97rx1/hGYeULm
         0flpaFH/sFdnlp0awKpTr8eaMC9B/zZoDGubX6yyGIu3JxLfg5bVwVWhTSIakRG3jRCC
         zEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nEhuJO1Ynor4weZ/NdgsrjcDQwLHIYNiPIAmRLX4GUE=;
        b=Vm1S+GUtnMMbix4kqWatVZa/6qllpdnnsd9zIV4AzB0ihRHHehRpJud2GURqW9HEP9
         EkKexUcET0dZI13eaIH8sPca0n+fQvqCIfMACgwLLxVgR6ee8BObjsARwJYKGmEb1Lbe
         N3cptWiDoNLCMcYqm+XxHsIXRBe10sBZcnT2PJcmFYZNF4NYB90DzPN/vsdGqpDPnwXm
         Syv5qjIkTn5VcNEi7tr4z49qL62EOzSRx9zEkQupsiuvwv4kAKowvQcmJSbwFsaLOWvq
         jN5ipoufAPoC24XEwsp1MaEifmy/bAyWGdXp/nH/oxbIj8pkk4CHiIlMWLc5xsm0egw7
         f/MQ==
X-Gm-Message-State: APjAAAXNfmWr3O1uzPFbz4BUae/UC9DM5+RPvK61ybtEQSAd/nFlNAkY
        9pX8q/z09PzaXLque5bXNwS5fA==
X-Google-Smtp-Source: APXvYqyZ/4SJ6b3JR9/ZurrOnqflqzaXFZbRf5gCuPX1ZCzXs5PbtTx1IfO1JJabzZ+xsr5JsHuApQ==
X-Received: by 2002:a62:6807:: with SMTP id d7mr52800695pfc.75.1556390384509;
        Sat, 27 Apr 2019 11:39:44 -0700 (PDT)
Received: from cakuba.netronome.com ([2601:646:8e00:4a0b::2])
        by smtp.gmail.com with ESMTPSA id r11sm36708305pga.87.2019.04.27.11.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 11:39:44 -0700 (PDT)
Date:   Sat, 27 Apr 2019 11:39:40 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban@kinvolk.io>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Iago =?UTF-8?B?TMOzcGV6?= Galeiras <iago@kinvolk.io>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: sock ops: add netns ino and dev in
 bpf context
Message-ID: <20190427113940.223fd4d1@cakuba.netronome.com>
In-Reply-To: <CADZs7q7O9TL5wXFBq_SgAdNCkzO=3tyLnF1_chthX3jao=PKqA@mail.gmail.com>
References: <20190426154848.23490-1-alban@kinvolk.io>
        <20190426140323.4edf1127@cakuba.netronome.com>
        <CADZs7q7O9TL5wXFBq_SgAdNCkzO=3tyLnF1_chthX3jao=PKqA@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2019 12:48:25 +0200, Alban Crequy wrote:
> On Fri, Apr 26, 2019 at 11:03 PM Jakub Kicinski
> <jakub.kicinski@netronome.com> wrote:
> >
> > On Fri, 26 Apr 2019 17:48:45 +0200, Alban Crequy wrote:  
> > > In the unlikely case where network namespaces are not compiled in
> > > (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.  
> >
> > Naive question - why return an error?  init_net should always be there,
> > no?  
> 
> True for netns_dev. However, without CONFIG_NET_NS, we cannot access netns_ino:
> 
> (struct sock_common).possible_net_t.(struct net *):
> 
> typedef struct {
> #ifdef CONFIG_NET_NS
>         struct net *net;
> #endif
> } possible_net_t;
> 
> And I don't think it would make much sense to allow access to
> netns_dev but not netns_ino.

Right, if CONFIG_NET_NS=n we could just take the pointer to init_net
directly, and not worry about the field.  IMHO it'd be preferable to
changing the UAPI based on kernel config, but I don't feel super
strongly.
