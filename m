Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C83FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB820869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573157113;
	bh=OEHtBJP5r/Yi+d9gffFXWegbIoOM1dAhx6W/6sx7Wso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BgI1yIrq7cykY3ISWMMqi3JyzUoX//a1tQTWLVJUFX7NN74Tt4TaS1CotJVUdWSyg
	 hKvkrlefdNWw5V5Sz5MBZK1ywST7CXVb6VC+al6BY8OmqbTKkzwa6QY+oLkTVz12hB
	 sDpwrPlnPmOuVgNFGgivjATj1TA7riPFnO3vVuD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfKGUFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:05:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40101 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfKGUFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:05:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id z16so3162650qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2IfBSlt6JJz6DUZsXLxMwPQei2g8TSez+84ZzUxiR4I=;
        b=BwQgtoJDjgwMoU6wIwHtiqWgnesn4Dez3jjYnh44A6yI8XiML2LMugg0ZccIbIgEAZ
         /5ssPWiIIhoMoP7t1wYDvoqefo+ASD2rWBN4E38tR5lwUXWy8gcjUWq7idw6fdtjl8q3
         eJuanwcMU8zu6gDlLVGNEiFV4DH2VmBdQllVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2IfBSlt6JJz6DUZsXLxMwPQei2g8TSez+84ZzUxiR4I=;
        b=pfar6zfPhLUIdjoKs8M7Ai8gps1/t9Eu/Cg4x3zCWowFSLbBduGWgmvcgbGHd1LLkB
         w0aTWb/QMvaV/zQLkfSefN7dZQNfae1YpVVsKzHe0HqosW2hIfKJrNaF6VpCVMPTp7hQ
         hc/DW8MQpSbTK8RMQKrOkNWhPQz/zL1zRVH01j9V4riuU0dnesqC4Gu1wUNEdrmmdxqD
         ZeIXrGpDuoa0IlfdKQVSotIc5yHv16gMflHdlJ8brPEXGan5yCi2kwpMjozU6Hbu8eA5
         3k4/RoWPFGBDtoqqIsGuVv5FNQkrGZWr6KkqR2xAqtRlHq/tcqAiueLTjaoCFXk3nahX
         89aw==
X-Gm-Message-State: APjAAAW6d9IzagzUhhKtMAoVo6xy0YNBiQnbpov3pfjrmWRR7HVdxRWH
        X6/7tNT2xrGUUcdGE1XDAqYb0pbLWgrSnQ==
X-Google-Smtp-Source: APXvYqy+7V4oF7mvcezJrEuRKHwtfMHVLzQS7gzTgczifvXQlKRdAn0Hnu8Nl/pTRKQde28LeshEZg==
X-Received: by 2002:ae9:c20d:: with SMTP id j13mr4502676qkg.461.1573157110631;
        Thu, 07 Nov 2019 12:05:10 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id r29sm2045931qtb.63.2019.11.07.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:05:09 -0800 (PST)
Date:   Thu, 7 Nov 2019 15:05:08 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: Add base-commit trailer usage
Message-ID: <20191107200508.j4qm7ic42pijkr2a@chatter.i7.local>
Mail-Followup-To: Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191030140050.GA16353@pure.paranoia.local>
 <20191107130052.21290e73@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191107130052.21290e73@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 01:00:52PM -0700, Jonathan Corbet wrote:
>On Wed, 30 Oct 2019 10:00:50 -0400
>Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
>
>> One of the recurring complaints from both maintainers and CI system
>> operators is that performing git-am on received patches is difficult
>> without knowing the parent object in the git history on which the
>> patches are based. Without this information, there is a high likelihood
>> that git-am will fail due to conflicts, which is particularly
>> frustrating to CI operators.
>>
>> Git versions starting with v2.9.0 are able to automatically include
>> base-commit information using the --base flag of git-format-patch.
>> Document this usage in process/submitting-patches, and add the rationale
>> for its inclusion, plus instructions for those not using git on where
>> the "base-commit:" trailer should go.
>>
>> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>
>I really wish we could find a way to make submitting-patches.rst shorter
>rather than longer - it's a lot for a first-time submitter to work
>through.  But this is useful information, so I've applied it.

I think that's the eventual goal, and I'm happy to take a stab at making 
this page shorter. The easiest would be to rewrite that page so that it 
only includes git-specific instructions. I think at this point in time 
we can safely say that anyone who need guidance on submitting patches 
would be already using git -- anyone who doesn't use git for that 
process doesn't really need this doc anyway.

I'll work on an RFC patch to slim this doc down.

-K
