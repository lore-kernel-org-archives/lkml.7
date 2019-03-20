Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E956EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B368D217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W8TdeH1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCTCyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:54:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36477 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCTCyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:54:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so804312pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLDJSIDvB3voIXsx3uaIAW5/phZOL5lOm5TrZxnVa50=;
        b=W8TdeH1rNuB5b7L4HYe6T4ot2Z7cNQML4UOSN4kNWhJwDsCv8m/yKb4n94cYQln62B
         ABuU0zaHOU0uBbrW2tWrwQhwahzzKwSGfIz+resLx4c8H2VoowZgQ6Om1TGZHrsZsvYr
         J2BdNs3lu0j69OjSomINVqWM0VxgHMssnRYiF9Ig9BJJlxhJvq+N7KIs7x/g9MSorbP5
         S8SlTmRShCKeHuCw82BrIvc/JunPq2Fun+/bGb77dXkcjTkWfApLpUc4YLtQrH2vtcvS
         JQQ6mql+uJ8ns7bbt8DdaeCNrBdUoManuYa/EjxQ4aXHx9w+kw0q3IXfMvCZsRxC7PV4
         AgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZLDJSIDvB3voIXsx3uaIAW5/phZOL5lOm5TrZxnVa50=;
        b=a8t8CQc8tooIdAN3w1QJK+z8QI8MWpcms43AzcTNaRpzLAjX29EupEh4juJvA1fwmh
         A2+Oj4qg3w7KXgNgqJuELGsufxTTn0x+M2Zxn8LkSx+yBLnvieDgX+F9V/keDUD5OefW
         f7dN0Xb5WISGIDbxeDqZGZ5RbhD7ES6x4sVqLrBnyF0MBGS1f146WsWwRv8Dng4f1HNu
         Gq7oQfAZGTjMp7FfuQ0q1I66s87lOB8F3KpZCi4XN5yWdYBHVAKFphKnGU7i1XJlKF+3
         qFYl8bPxbCSEelVNbBfRyAQG79JnJhPsuvA+B77gzBOD33kPqKeQlu/J8Nxnt/NVx5V8
         oeaA==
X-Gm-Message-State: APjAAAXpCdr7UrZXd9/9Pd9c6SpoUCbN4Q1GBxkR0mc1X64Q0S1mW029
        0QV2PnAtg2V5Eb2foTX6zdOpiA==
X-Google-Smtp-Source: APXvYqytu3Q0SPwwuneKuggYzZxtsGo2d/pAI1t5XD4kd9KWfw/AyQMgpfAiVAsyvRRFFs7MCd5K8g==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr5197734ply.14.1553050451456;
        Tue, 19 Mar 2019 19:54:11 -0700 (PDT)
Received: from localhost (2001-b011-7001-1ed7-23f1-a55b-5e6a-d75e.dynamic-ip6.hinet.net. [2001:b011:7001:1ed7:23f1:a55b:5e6a:d75e])
        by smtp.gmail.com with ESMTPSA id l5sm561016pfi.97.2019.03.19.19.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 19:54:10 -0700 (PDT)
Date:   Tue, 19 Mar 2019 19:54:10 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Mar 2019 19:41:18 PDT (-0700)
Subject:     Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
In-Reply-To: <c9f13314-204b-10a5-e9eb-2c4d8fca6c90@deltatee.com>
CC:     robh@kernel.org, dalias@libc.org, ysato@users.sourceforge.jp,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        sbates@raithlin.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com
Message-ID: <mhng-bc5a03c7-1387-43e2-bd72-fb03e344e196@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 10:56:52 PDT (-0700), logang@deltatee.com wrote:
> Hey Palmer,
>
> On 2019-01-23 12:56 p.m., Palmer Dabbelt wrote:
>>> @Palmer: if you can just look at taking the second patch, I'll resubmit
>>> the first one to the appropriate list.
>>
>> Works for me.  I'll queue the second patch into my staging branch, targeted for
>> the next merge window.
>
> It doesn't look like my sparesmem patch made it into v5.1-rc1. Did it
> fall through the cracks?

It must have, sorry.  Is this what you're referring to?

    https://patchwork.kernel.org/patch/10754911/
