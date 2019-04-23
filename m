Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D64EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD58217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YfLOTsxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfDWOQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:16:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36871 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:16:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id z16so16233155qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dU4XmvTLS3rOkVwSZthKkfLsWUIXQrIKKxW0nz+S4E8=;
        b=YfLOTsxYJi+MYCEhwbH53t1BCdFMzff/wyIkOExL24PJyv+4Jxh1tceswNEcTQXBEX
         QERm9pnu9C0HxJUt1DQHrNpCzCaBLCzmOpQ4X1dyRNo2dsYL5GkQJC3IBHz41GO0ESQq
         KASzOP0RawE9pLAonozZZKr5U0Gmzl3Ll6HWdJ/PzyHXzhu2iv7lQ/G7dSviKEzD1v0/
         7WVuy8VZN4sVBtjw6fzkQhUBnuiF6Vod431pxvPGbHI1/zsyg1MygtP6JE2U7IsUqNi3
         rYCr0+1rqXevdUF/Cp5bE11l1LxP1B8UOtYo26Rha3DS92WnSxb79XomBZQd3Xv4vr9J
         nY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dU4XmvTLS3rOkVwSZthKkfLsWUIXQrIKKxW0nz+S4E8=;
        b=FUUOF7RID4yZ01qPuELnmp60zxnAFuMpfbNxYxA5l16Vq5EDfoR8MdYEOfgtRXcA+c
         MceIp+bq3EpWJyFlSrn+RWkrp8PH7Olzdy+zyt+1NFR1Y9brQZnrSeq0ID5Q7rWQdAye
         TJZp6fBuD4ck0E2m/ogp9/vTAXNXfmgSwuZJZ8CMTxEPW/XAZe9SWYtqZycqBbFAmUo/
         qaxuEes4jsmxNGpyUCzxRbqrEJTxy8/7w+qNwgrTCnsBrmGWF6xV8O/RvGss7N5rRDTj
         Xo2lut4zVgSJ3vKzC/YNcqZ5KQrsmNHwMId4E9eJG50iPRjH4ZGBatjVebc1Tj2o2OPb
         pqvg==
X-Gm-Message-State: APjAAAXqFc5vgPzF7aJZ9qSbadzJs+A2QGQd0wiigpSLxR6iQzSOF3NM
        4k4gTIE70sqx/idAEepAOa84MQ==
X-Google-Smtp-Source: APXvYqwke8GoKe/huQ0hdYBK53D/R9zAXDjkArn2prUzXvX7Cv5+63It1+0rVEFRqi5fRnGC/sTr3Q==
X-Received: by 2002:a0c:9861:: with SMTP id e30mr20929902qvd.52.1556029009034;
        Tue, 23 Apr 2019 07:16:49 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y14sm7912196qth.48.2019.04.23.07.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:16:48 -0700 (PDT)
Message-ID: <1556029006.6132.1.camel@lca.pw>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
From:   Qian Cai <cai@lca.pw>
To:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
Date:   Tue, 23 Apr 2019 10:16:46 -0400
In-Reply-To: <20190423132518.GA16353@zn.tnic>
References: <20190409040502.55361-1-cai@lca.pw>
         <20190416171104.GI31772@zn.tnic>
         <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
         <20190418074510.GB27160@zn.tnic>
         <20190418095015.GB18646@arrakis.emea.arm.com>
         <20190423132518.GA16353@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-23 at 15:25 +0200, Borislav Petkov wrote:
> So I guess free_init_pages() should be somehow telling kmemleak, "hey,
> just freed that object, pls adjust your tracking lists" no?
> 
> Because, otherwise, if we start sprinkling those kmemleak_free_part()
> calls everywhere, that'll quickly turn into a game of whack-a-mole. And
> we don't need that especially if kmemleak can easily be taught to handle
> such cases.

In reality, this is only the second place that needs this kmemleak_free_part()
call for all those years since kmemleak was born.
