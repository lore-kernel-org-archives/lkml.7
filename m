Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E421E24673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAS0ndSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLFPR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:17:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42675 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:17:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so8133195wrf.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wZeYmwl/YXx/GXyGvgJM6YWiEkEWNw1TRB/m4JK2Mo=;
        b=iAS0ndSZ4+L7Yw0ilQ4vuMWKIlFL9Qowv0BJ8daD8ZwPeyFRl8pT5AlYH01+oAvK54
         JXsUAVYKh2EZlQby55NWapr2AXx8FvBl/g5UbdSlVtrRzMIOaKKYUNe3GKEv5PYXKAJJ
         JouAwi8otTBJgZZA5/IIwwZ8fivE7ve70GTH+1dUBod8FFe8Cc2zeRTQVUGlDrTzjQlH
         FxGkWNnFPKN1wegAEifsurvD8B0hIsLax2RMIJWC9rIxo+kUmcho8slLD9esEW8n9Qnk
         hyhAdipsLvSRRWWoRJ/9612misRRgQSqgJPi5VDZuiMLObgBZdKam4Qm5/S5JYgw6m4g
         eNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wZeYmwl/YXx/GXyGvgJM6YWiEkEWNw1TRB/m4JK2Mo=;
        b=J2lLio1vFQQubMj6CSN+1ZNou0YzzndaS7LUSzwnpWsYcq7h3x8YCjBFc1f5bm0B6k
         qY+vyT1XwtCSDeA9gb5ikvfvpJNw88rrZz9+YU6e8znbW8mIR61PTWyK5N6HeLSTGJ4u
         WkfeVWEIiKXXAXeCl96qRTcIi+OUDTU4jDff4sy0NfbQHTpYqHLVK6s1ZMR1rlb1LPD9
         CHfLhS5mvkpuE2BAIGXhbqfbS5sGi5UD8J5dAFf1EsRNhG3+m2teLkDkQ3gwpYtl08Tb
         DWpvLnvHlNuX7WkzuOaY+TL6j3lCaCn7OC3t/muhz5jTirfW80+vitkRnNGEey1cKwKz
         5sSw==
X-Gm-Message-State: APjAAAV1X/7JjOpy++cGAAWnDCnsUlsq2tyxaEEz3AejLRd0H9G1jw0g
        uAm7DvooXfilgGV88e7y7IQ=
X-Google-Smtp-Source: APXvYqzgtOQLhZ0eIRYIqblo1OUpve9MsEMDDEcKOnCYwn64157LXZf53QH0NFo4rwIHxXlbLbCN2w==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr16862837wru.170.1575645474304;
        Fri, 06 Dec 2019 07:17:54 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5sm16932021wrh.5.2019.12.06.07.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Dec 2019 07:17:53 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:17:52 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, richard.weiyang@gmail.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or,
        tglx@linutronix.de
Subject: Re: [Patch v2 4/6] x86/mm: Refine debug print string retrieval
 function
Message-ID: <20191206151752.phfiyls3govuqeja@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
 <20191205021403.25606-5-richardw.yang@linux.intel.com>
 <20191205091311.GD2810@hirez.programming.kicks-ass.net>
 <20191206015126.GB3846@richard>
 <20191206102746.GD2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206102746.GD2844@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:27:46AM +0100, Peter Zijlstra wrote:
>On Fri, Dec 06, 2019 at 09:51:26AM +0800, Wei Yang wrote:
>
>> >> +#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
>> >> +	static const char *sz[2] = { "4K", "4M" };
>> >> +#else
>> >> +	static const char *sz[4] = { "4K", "2M", "1G", "" };
>> >> +#endif
>> >> +	unsigned int idx, s;
>> >>  
>> >> +	for (idx = 0; idx < maxidx; idx++, mr++) {
>> >> +		s = (mr->page_size_mask >> PG_LEVEL_2M) & (ARRAY_SIZE(sz) - 1);
>> >
>> >Is it at all possible for !PAE to have 1G here, if you use the sz[4]
>> >definition unconditionally?
>> >
>> 
>> You mean remove the ifdef and use sz[4] for both condition?
>> 
>> Then how to differentiate 4M and 2M?
>
>Argh, I'm blind.. I failed to spot that. N/m then.

Never mind. I always do the same thing :-(

-- 
Wei Yang
Help you, Help me
