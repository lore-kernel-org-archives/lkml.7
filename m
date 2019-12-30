Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD67BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EBE206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NQAQr7m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfL3BvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:51:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34681 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfL3BvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 20:51:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so28798451qtz.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DQz0FjxnkcrZB95uhqUPghs+uepx++Cg0e03CfkfPoI=;
        b=NQAQr7m/F84JH6xZgLELtcSkwP8nDBWDreyVi/HwY6F+R43tc1G6CqQ1ZDu4ZZlufq
         3Xb8mxcqIxjSyfjiAkSJ603jB/Iio7i+XeJiG5MjAsV2E7hiLnNEKcLzmeEipmCg1Yut
         h41C8++kK5khfZ1ScnrCeyJGectHWrMS2ZNrxeyGnLhDoz2k0QtWDU7AydNZctkJI62n
         NTHF7uI+hScdljY+KOxgYAXbn8rZ8PP83oIIS7vWGV5y1RdsKKMflYrlbo0VevLH+nOX
         R0H8MB/RhTNYwvUjha/DLBj08zFieM+CNEV1v1ORLVREf2uGTMxN/s/RkqcLp7rJ2eBn
         2jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DQz0FjxnkcrZB95uhqUPghs+uepx++Cg0e03CfkfPoI=;
        b=Cq5s8wnMJheuE7oDejYWTOLJ4w1gjkTLOvQLj8GXzZttJ7iyU7DHTwvovD9X9B1J4s
         03Tr9asLW41hYssZuvZBH1jjWASjW2ND4MLMWWicnBsvL3TLVmznIOPp1dCGKMOBv3ue
         bUUn5Gx15ULSF317KjHN7ITt71fgs1rRZOS4OP5K/r7OD/vKVsyu6Yx7fda6s00cguaS
         PzBYu6506cHgSLPs8NF5HscRZE/88OXaHEPTt2OdNm08ji5Rdr7UWhqp1D1aNvZ8yaqR
         0uHEx/WtlZ3uDUe1ohDw9k3aAmJmhJfeALBeV42McKfxk6Qv6NrMD20wlDm8VeHnbumr
         3+Ug==
X-Gm-Message-State: APjAAAXs3IK0LG29mpmPrAEaLuynYOA1nJxdOaXB3iOeHDE3C0FCAuqw
        cTnr6EffDO/uJWr2srh1IHBFdA==
X-Google-Smtp-Source: APXvYqwzmOuuJ/FWC8WUTBhMOEyOdQD8LKElXYoAdbbrcMNiJXbkj+74dGHMmtNBqsGrYq3Tk3/Bhg==
X-Received: by 2002:ac8:1109:: with SMTP id c9mr29537417qtj.251.1577670670398;
        Sun, 29 Dec 2019 17:51:10 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q126sm12015666qkd.21.2019.12.29.17.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 17:51:09 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM panic occurs
Date:   Sun, 29 Dec 2019 20:51:08 -0500
Message-Id: <D8935037-8A59-4A64-9C35-52486DC01015@lca.pw>
References: <1577669436.25204.8.camel@mtkswgap22>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
In-Reply-To: <1577669436.25204.8.camel@mtkswgap22>
To:     Miles Chen <miles.chen@mediatek.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 29, 2019, at 8:30 PM, Miles Chen <miles.chen@mediatek.com> wrote:
> 
> Yes, printing top 10 will be too much. That's why I print only the
> greatest consumer, and test if this approach works.
> 
> I will resend this patch after the break. Let's wait for others'
> comments?

Sure, but to make my point clear.

Nacked-by: Qian Cai <cai@lca.pw>
