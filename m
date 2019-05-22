Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B89C18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F927217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfEVClA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 22:41:00 -0400
Received: from namei.org ([65.99.196.166]:33694 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfEVClA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:41:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4M2et1w006403;
        Wed, 22 May 2019 02:40:55 GMT
Date:   Wed, 22 May 2019 12:40:55 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC] Turn lockdown into an LSM
In-Reply-To: <20190521224013.3782-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1905221203070.3967@namei.org>
References: <20190521224013.3782-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Matthew Garrett wrote:

> Hi James,
> 
> This is a quick attempt to integrate lockdown into the existing LSM
> framework. It adds a new lockdown security hook and an LSM that defines
> the existing coarse-grained policy, and also adds a new
> DEFINE_EARLY_LSM() definition in order to permit lockdown (and
> potentially other modules) to be initialised at the top of kernel init
> in order to allow policy to be imposed on stuff that happens in
> setup_arch(). The goal here is to allow policy to be devolved to other
> LSMs on systems that have a secure mechanism for loading LSM policy
> early in boot, allowing creation of arbitrarily complicated policies
> without interfering with the common-case coarse-grained approach.
> 
> This should probably be extended so a uapi-exposed constant is passed to
> the hook in order to make it easier to write policy in other LSMs, but
> does this broadly look like you were imagining?

This looks promising!

An LSM could also potentially implement its own policy for the hook.

-- 
James Morris
<jmorris@namei.org>

