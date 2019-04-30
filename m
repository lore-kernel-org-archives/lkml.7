Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E15C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7612080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556598288;
	bh=YU28RkopbRaMt3cG6MbmxhwUTMY1xkAUDd2+tGnOoqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Z6dRIM8IC0lUcqWUixQWzNWQM98GEdBbnuFDtFPQVFCX5L39irmHDLFsG+G/LLN9
	 QTOCDt4MUnm6eGzt5oxJ4CcolvZHIxz+c88RvasDapmHnTzb/gZ/cpcB3+FBWrvwRN
	 e67++kPHMcgVxAa9EHfsMWIltnEdvpFZDeHm0yKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfD3EYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 00:24:47 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33606 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3EYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:24:47 -0400
Received: by mail-wr1-f49.google.com with SMTP id s18so19278576wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 21:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVA6yR4Sxy2an9BXJ5NALuY+dTspWhcDf3najxAmkPA=;
        b=nPeKKzZz5rmrdYvcZ5h29hW2YotW09hET0wvOByGsm56wjtEjm4bayirmeENjxYtBb
         UTaT113i/tWVOp3O6cAMgYhpBqLUPRWstymJK9/mnfktUb3yKrP/BAXxn5COPN41zb7O
         jqTK2ZNke3uY5NT9jo93w7NM9ih5y7GCLzT8/JpEqwP/66gfpziYpgZSHZ0rk5EXxKNy
         f9qDvug6ejJ97DGfpU7GL/ErBsO3mXFTzPrI+IKBK8R4wM4cUTqrWyCXPXne06lJrxeP
         arjKv7tD0dsBUzPS9KCNjY9Vwkw7hVw2hMTfBKFYjXd3fxAUcsLWB0IO72ZMJhLB68z4
         oMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVA6yR4Sxy2an9BXJ5NALuY+dTspWhcDf3najxAmkPA=;
        b=Eo37bzUIG3l1n0Ba3/GTiX3BsexKmQAYPi0QYpiRYOjtpFB/Drhmd+c/K2mP3g+QQd
         EHek01hNjBMMXpUBStTePLONTxsf22fMt8XYpBxamTGXTn0yJf81zhNs9yWNFnCsdslY
         EcBx3kou6mvhsguyXrYBZx7Az0RbQh8roG/kEF4iy+/K7reFmmt1aMFM0pVQIwVI/rex
         rdrqC/RsgJy+fQWd/Ail4ifaXde8IT7C4uZQC/63qTCVnrg3cl2AwxrPmT24yMi6cc+9
         SS92vAD0I0feSGvMZVzi3y9xZqaTbDso5LhoP5jC/wKRILOSwPTmZz3MmRJCzXeW2XB6
         D9ug==
X-Gm-Message-State: APjAAAVaP7LwXO4eTY0/IleADF2p/7Da2bZCjve0UgKptfKVgzWcsufJ
        zAq/4TDivRmJG8u+3PMAMTw=
X-Google-Smtp-Source: APXvYqxum5eQFtaTLaKo9hs0cIRwpQrCzktMQnT+4KdMyx3teIJoJCVvBTQiKi3Mkq8OkLsYmMEmHg==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr16153091wrp.241.1556598285871;
        Mon, 29 Apr 2019 21:24:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u11sm188077wrg.35.2019.04.29.21.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 21:24:45 -0700 (PDT)
Date:   Tue, 30 Apr 2019 06:24:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sched/cpufreq: Fix kobject memleak
Message-ID: <20190430042443.GB73609@gmail.com>
References: <20190430001717.26533-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430001717.26533-1-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tobin C. Harding <tobin@kernel.org> wrote:

> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> Resend with SOB tag.

Please ignore my previous mail :-)

Thanks,

	Ingo
