Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C39C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002332085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561447858;
	bh=qOPMdAefONiiQtGyOnVHuNOQa95t20MqHBIrIkRKEUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T0dIgpG6vDhkr1068pTIzcV8Brwtb5qE2L6xYVcpTkCmTWIlEASrxZaJgq3MbWcp1
	 0Kj9botktbIpjpUcgvuc2ogWjH1WFQXuISgjQzORV3Y9O88sW6sI8XRm7uX73i9Lyv
	 oxIouWztyXtawCYkd+TS7Ty8uvG0zTBxs5YV/nDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfFYHa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbfFYHaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:30:55 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954C720652;
        Tue, 25 Jun 2019 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561447855;
        bh=qOPMdAefONiiQtGyOnVHuNOQa95t20MqHBIrIkRKEUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSQEnRsKS6ZadDbgY0eboH0YIJh21cGvWvGF2pMUwxQiFDuUq6eISTrpthg6uIoUZ
         diWOwIoFZt7rST1C3aIR7UZ3yhcoTKhABAjNY1CEdfIi1g5E/6a8kMSr2jB2iZVwGd
         48TdJfAWfbZ3qIHVtbPKg9UkpWY/ZnN50vuW3lRc=
Date:   Tue, 25 Jun 2019 15:27:15 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sudheer v <open.sudheer@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>,
        Shiva shankar <shivahshankar@gmail.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch 0/5] *** DMA based UART driver for AST2500 ***
Message-ID: <20190625072715.GB18197@kroah.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
 <20190621131729.GA9997@kroah.com>
 <CAE-5=DTdo4qDUPRw+Giu=bCcpqu7EdLDt5ddDvqLSgGbuqE1Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-5=DTdo4qDUPRw+Giu=bCcpqu7EdLDt5ddDvqLSgGbuqE1Fg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:30:32AM +0530, sudheer v wrote:
> Hi Greg,
> When i last submitted patches, i have not added change-logs.
> and also used custom debugs instead of kernel dynamic debugs.
> So i have resubmitted the patches , considering you have discarded old set.
> I want to send any changes suggested  from now on wards  with versioning
> V1,V2...so on.
> Is this acceptable for you? or should i submit the patches again as V1 once
> again.?

No, please resend now as a v3 series, with the information that says
what you changed from the previous versions.

thanks,

greg k-h
