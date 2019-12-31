Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B4BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C7D2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSWj3wsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfLaCAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:00:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfLaCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Ol1fK/4gXmBq5ENpSBID5RX1BAyG5LAjEmY2bGxy5E=; b=tSWj3wsGDbecSD8noCvW3twMQ
        e4oTmruQIONQYsMawGUmZHRZVffhi14Mp8UF7UDLjPFrryOVlHR7ZDdxPOWVt2TJ03CWmzGbxITSp
        HJpSI6cfbquhaX3MRFnS60IbgiOfbQ2lppM+pXhHSezJbYqz0TFxAqr98LKz1QeGtVuAr+9FWhroR
        lvVofQvqVkY/TpY4W1wPC2t1buJctvN6hbg2smbrSZwNzu3Z+9wL/Vp2VfAxL9bFQCIXbhBqrOc7s
        Wb19iaSmlrhqlguMkXIzNLKvyM2Z1RZcFsON9ENcdyyQ7sHrHE8RNvgU7Lnwv2WEdSBIPqbOV2HUC
        n8VURdP3g==;
Received: from [2601:1c0:6280:3f0::34d9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im6pO-00061l-9o; Tue, 31 Dec 2019 02:00:10 +0000
Subject: Re: Why is CONFIG_VT forced on?
To:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ce685c3-a14e-0cc9-1c9c-4673bfab2e25@infradead.org>
Date:   Mon, 30 Dec 2019 18:00:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 5:45 PM, Rob Landley wrote:
> On 12/30/19 6:59 PM, Randy Dunlap wrote:
>> #
>> # Character devices
>> #
>> CONFIG_TTY=y
>> # CONFIG_VT is not set
>>
>> But first you must set/enable EXPERT.  See the bool prompt.
> 
> Wait, the if doesn't _disable_ the symbol? It disables _editability_ of the
> symbol, but the symbol can still be on (and displayed) when the if is false?

Yes, displayed but not edited.

> (Why would...)
> 
> Ok. Thanks for pointing that out. Any idea why the menuconfig help text has no
> mention of this?

Hm, it's disappointing that EXPERT is not mentioned there somewhere,
when using menuconfig or nconfig.
When using xconfig, and selecting "Virtual terminal" VT, xconfig help does say:

type: bool
unknown property: symbol
    dep: TTY && !UML
prompt: Virtual terminal
    dep: TTY && !UML && EXPERT <<<<< so the prompt depends on EXPERT
select: INPUT
    dep: TTY && !UML
default: y
    dep: TTY && !UML


-- 
~Randy

