Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1388C4CEC4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 09:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7898F208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 09:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkyMdLbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394076AbfIUJJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 05:09:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37747 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392557AbfIUJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 05:09:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so6149995pfo.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LKS6iRhORtVWtWzPRk2V93JoQAB4JDX0z138KY8j8Ak=;
        b=SkyMdLbVZeuAeURGdY/fK7VUmGBH5duim15ZdpccY6a9VaRa7ysYDVaA7VUcqecynC
         NSpY6XX7eKwmBaeUoQsRnsl8Ko0gjuRoRIAfs8u3KYHs5i2OYzOw/fFTozNtkUaCu2uQ
         yNNr+zvypRK5jh7JvO6BN0ixVJ+hDH1K+zQEW1ntYn0IoTebzEtKHcjp1P948b9Mwn5K
         FZwnxU3syHnu79tDtL0nisC7ArTpimgR+i6/Y1d2xBOG+X3gSt6oxZptCPjK9AUW2rlQ
         f2zDP2C8ZNKIQHotlvns49lEBLnfHOyh03czL/hGG2EChz39ihxw7K/DIedL8LuJxDrb
         zehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LKS6iRhORtVWtWzPRk2V93JoQAB4JDX0z138KY8j8Ak=;
        b=isFTe0cRyOExfCY9sP0hn2Iwoy8RwdniEM2zAfm9BPe9buJzcMt+zqQPLd04Fjuijo
         GdXqMeYfRdPajYq2PIxXKRSnKszHxdEFyV8StH43cB+G3mVCd9sXYss7DnmEyMVex887
         Zeyiv0ysvMys4maD7OEDmswoH7H3kY0wgYWIL9zzzDgvGgPx97eL/zXjqgNZKX8C19iW
         nqlBHohFocOk2RSNaWNmcFx5wLorLe0H0B5Rn/FwIzTuFAH1JoU/zYDx332+Zfrh4X0t
         6dwaNIiVhEyFT87M0rhL7KY4vsFgs3s8i0AunupMX9tQ52Vf2eDRW8pI06CjFBJ7K2vl
         n2Ow==
X-Gm-Message-State: APjAAAVxPYdjPRMQsJZu+RxTGYsj94fJRDUJ9n/YY4jgX9O9zoNALRRM
        rCr4Aqp7QqzvN6J/V/ra9xe6MQ==
X-Google-Smtp-Source: APXvYqyDG2iSDN+jBYdCL3+alE/9Xq3bNU+YDf3e+OZLkMg4U9lsu0+pJcxGpuPE3fYiB4Uxvo8gvQ==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr19648574pgc.348.1569056941451;
        Sat, 21 Sep 2019 02:09:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w69sm6951409pgd.91.2019.09.21.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 02:09:00 -0700 (PDT)
Date:   Sat, 21 Sep 2019 02:08:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Miles Chen <miles.chen@mediatek.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm: slub: print_hex_dump() with DUMP_PREFIX_OFFSET
In-Reply-To: <20190920104849.32504-1-miles.chen@mediatek.com>
Message-ID: <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
References: <20190920104849.32504-1-miles.chen@mediatek.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019, Miles Chen wrote:

> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> The use DUMP_PREFIX_OFFSET instead of DUMP_PREFIX_ADDRESS with
> print_hex_dump() can generate more useful messages.
> 
> In the following example, it's easier get the offset of incorrect poison
> value with DUMP_PREFIX_OFFSET.
> 
> Before:
> Object 00000000e817b73b: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000000816f4601: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000000169d2bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000000f4c38716: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000000917e3491: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000000c0e33738: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 000000001755ddd1: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 
> After:
> Object 00000000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000010: 63 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Object 00000030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
> 
> I think it might be worth to convert all DUMP_PREFIX_ADDRESS to
> DUMP_PREFIX_OFFSET for the whole Linux kernel.
> 

I agree it looks nicer for poisoning, I'm not sure that every caller of 
print_section() is the same, however.  For example trace() seems better 
off as DUMP_PREFIX_ADDRESS since it already specifies the address of the 
object being allocated or freed and offset here wouldn't really be useful, 
no?
