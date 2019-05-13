Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D67C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB10208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjUaS2Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfEMOhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:37:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42664 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfEMOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:37:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id d4so8112719qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b1o0hZ+fNp+TqSBs/mDlxw3u/lJ6G1FX/UwWcy48/68=;
        b=YjUaS2Vb2WjWhY+KnQogQB5+20ki2azppHbUzmpJZgic/3KY9g06lXHz/BvM0kJtIL
         1Zdg2dmUz7E4EhistgPWt5OUJTej4S6Xg5fZ2jQBxudAW7UvAMbp3MjwuBPyMjFgPWbv
         yMnHoYQRXE/zylYEN9NTvpsnIwMT3ghIzpH4I7g2K/19wSBHUKs/ACry1VDbSEeMFrvc
         298vpkrK2ITPmEM+JqHZyT0++tux8Rwu/EVd72Utiqn1Mp/m6XjF3rq0pbh1ypQgVqzM
         tsj0PHZsUx0Nwk8CjrHLpUrl4QnmTSoknvy7qmq/rcvfH+aYC0nOXd+Pr6U9eZYOroU5
         /IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b1o0hZ+fNp+TqSBs/mDlxw3u/lJ6G1FX/UwWcy48/68=;
        b=YrNrjRU5TKzA+KvupjvdlIn2ByDtEQAucyVeuj1W41X2izBaey1+hUFqajWUcsFHGq
         TFHPCoHyHBd/Esk2fnTBrPB1YK1ElhK7EMw0yfGplab1p88oiTrps/u4Fwj+xTRpEhco
         HLkEAXO9/HqNE84FyAxxP6VnpAuIA5qM320az/Iox99wi7kBTaYso94/BSywoFG4klWG
         hk3pmeTAbdRdI12+K3iUcsf4QM4kC1DhIdfDr53g5aYBlGcOjTTGqeykucJ7ZC5F0FM9
         sDjlLIZ7fm7lQJZIm9YvvC5E3JRTBTKbbZd93XqufgoAO4qsPpBFsf6uhd5cfWVQf6L7
         al7A==
X-Gm-Message-State: APjAAAX8hwjGAMaEm9fuUxTFcdcI4jIwvdW/DQ38wdWDXWyw54OPtss0
        5+/uSHRWGe8MJhi1u19qvOSq/g==
X-Google-Smtp-Source: APXvYqyE9yidVd20NwqlT7IuwKTOamtD8OZg57Oj+lzA9i/D/SK46op48Abs2O6fNuAfoth9stEEEA==
X-Received: by 2002:a05:620a:3:: with SMTP id j3mr5695470qki.95.1557758225466;
        Mon, 13 May 2019 07:37:05 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id y13sm11310485qtc.21.2019.05.13.07.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 07:37:04 -0700 (PDT)
Subject: Re: [PATCH] modules: fix livelock in add_unformed_module()
To:     Prarit Bhargava <prarit@redhat.com>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
References: <be47ac01-a5ac-7be1-d387-5c841007b45f@google.com>
 <20190510184204.225451-1-brho@google.com>
 <dd48a3a4-9046-3917-55ba-d9eb391052b3@redhat.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <d968a588-c43b-cfe1-6358-6c5d99f916a3@google.com>
Date:   Mon, 13 May 2019 10:37:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <dd48a3a4-9046-3917-55ba-d9eb391052b3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 5/13/19 7:23 AM, Prarit Bhargava wrote:
[snip]
> A module is loaded once for each cpu.

Does one CPU succeed in loading the module, and the others fail with EEXIST?

> My follow-up patch changes from wait_event_interruptible() to
> wait_event_interruptible_timeout() so the CPUs are no longer sleeping and can
> make progress on other tasks, which changes the return values from
> wait_event_interruptible().
> 
> https://marc.info/?l=linux-kernel&m=155724085927589&w=2
> 
> I believe this also takes your concern into account?

That patch might work for me, but I think it papers over the bug where 
the check on old->state that you make before sleeping (was COMING || 
UNFORMED, now !LIVE) doesn't match the check to wake up in 
finished_loading().

The reason the issue might not show up in practice is that your patch 
basically polls, so the condition checks in finished_loading() are only 
a quicker exit.

If you squash my patch into yours, I think it will cover that case. 
Though if polling is the right answer here, it also raises the question 
of whether or not we even need finished_loading().

Barret
