Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB7C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB2320896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfFMTLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:11:13 -0400
Received: from namei.org ([65.99.196.166]:38978 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfFMTLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:11:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5DJAmSG022560;
        Thu, 13 Jun 2019 19:10:48 GMT
Date:   Fri, 14 Jun 2019 05:10:48 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Prakhar Srivastava <prsriva02@gmail.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, vgoyal@redhat.com
Subject: Re: [PATCH V8 1/3] Define a new IMA hook to measure the boot command
 line arguments
In-Reply-To: <20190612221549.28399-2-prsriva02@gmail.com>
Message-ID: <alpine.LRH.2.21.1906140501300.14107@namei.org>
References: <20190612221549.28399-1-prsriva02@gmail.com> <20190612221549.28399-2-prsriva02@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019, Prakhar Srivastava wrote:

> This patch adds support in ima to measure kexec cmdline args
> during soft reboot(kexec_file_load).
> 
> - A new ima hook ima_kexec_cmdline is defined to be called by the
> kexec code.
> - A new function process_buffer_measurement is defined to measure
> the buffer hash into the ima log.
> - A new func policy KEXEC_CMDLINE is defined to control the
>  measurement.[Suggested by Mimi]
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>

> +	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_event_data event_data = {.iint = iint };

Minor nit: looks like this could be simplified to:

	struct integrity_iint_cache iint = {};
	struct ima_event_data event_data = {.iint = &iint };

which also saves the later memset. 'hash' can also be initialized with '= 
{}'.


-- 
James Morris
<jmorris@namei.org>

