Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7FC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722B2216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c9zNKYT1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LQqKWQCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfGAPjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:39:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfGAPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:39:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ECCD860117; Mon,  1 Jul 2019 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561995578;
        bh=xXA0JQA3DqSdu/xQaCcpOyC/vA5BbKoekfoldJAadOc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c9zNKYT1cY9/3sRsYDp5mPmj0tcVgoTbGWS23DUm9DlgFBalqRbxDcbtOLOYp25GS
         nM3/TBT+29vaY6lYYXiZH7FMwJ3jr2z+pHzLWxByRrCLsWK18vyCGiyEqs2SfUkVyJ
         WqTHVewO63DL8haw86nc1ltwksU7je5BcyKTfdCM=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B02260117;
        Mon,  1 Jul 2019 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561995577;
        bh=xXA0JQA3DqSdu/xQaCcpOyC/vA5BbKoekfoldJAadOc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LQqKWQCk1KyDaB/TnxOcjySMqP1eVn7YD56AHHgGQHE/F4DDQYuwjDE3fUdjM+Dtq
         ypeMu86YP4iWw9ngU+PQN2GhmZDQxvZxIUeIN52Nq2BunMgLP4aPINcw+62N+rfG+r
         YBMamtXvQUrV4cmwon2CdKf8/vxleCVB9/bnqYr4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B02260117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: Perf framework : Cluster based counter support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <7ce0c077-06ef-676f-1f7b-61f3ba8589d1@codeaurora.org>
 <20190628165915.GB5143@lakrids.cambridge.arm.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <aca3b787-af8d-79fb-c23f-38accdd5d4e0@codeaurora.org>
Date:   Mon, 1 Jul 2019 21:09:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628165915.GB5143@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/2019 10:29 PM, Mark Rutland wrote:
> On Fri, Jun 28, 2019 at 10:23:10PM +0530, Mukesh Ojha wrote:
>> Hi All,
> Hi Mukesh,
>
>> Is it looks considerable to add cluster based event support to add in
>> current perf event framework and later in userspace perf to support
>> such events ?
> Could you elaborate on what you mean by "cluster based event"?
>
> I assume you mean something like events for a cluster-affine shared
> resource like some level of cache?
>
> If so, there's a standard pattern for supporting such system/uncore
> PMUs, see drivers/perf/qcom_l2_pmu.c and friends for examples.


Thanks Mark for pointing it out.
Also What is stopping us in adding cluster based event e.g L2 cache 
hit/miss or some other type raw events  in core framework ?


Thanks.
Mukesh






>
> Thanks,
> Mark.
