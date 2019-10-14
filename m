Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A68C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC08721848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571056286;
	bh=+LqcF8ByKwLJwZRdsiJGDCF/AwZeNuqrwRk1LUOVGiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DWv5svQz+sA+lowp8XdVrT5xIlazLCiIIhxfXJ8KYWSmgWhewK5O+81Azjkuj9b9a
	 Kj+QxmwthL9Y2oFXTHtz8VsG2rQussuRHzbH83N+YuZave3LXb89fdpEDl8Y1BD7Jb
	 Gyd6oWxcX0lRlawoghzzjxhmzBHXoTa65ajXnXj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfJNMbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbfJNMbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:31:25 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D829821744;
        Mon, 14 Oct 2019 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571056285;
        bh=+LqcF8ByKwLJwZRdsiJGDCF/AwZeNuqrwRk1LUOVGiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ke21MA3mK/zL6DlY8zp9j7AwJiGAOen5DbtEAOSMjutmaPWJ/nwqZ9eld33r8elJI
         tlCTWVhSvaILV0qlwjcaxZuAmIHCdnZZaiJrPQN7Z/k6FEr4PteylCKAgEIrLdAaBC
         9hogT2lVU7My4BBgTp6nhgk0JDCBn/QTU9JBH9/U=
Date:   Mon, 14 Oct 2019 14:31:21 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191014123120.GB6525@linux-8ccs>
References: <20191009223638.60b78727@oasis.local.home>
 <20191010085846.2e7cc625@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191010085846.2e7cc625@gandalf.local.home>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Steven Rostedt [10/10/19 08:58 -0400]:
>On Wed, 9 Oct 2019 22:36:38 -0400
>Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2029,6 +2029,37 @@ static void module_enable_nx(const struct module *mod)
>>  	frob_writable_data(&mod->init_layout, set_memory_nx);
>>  }
>>
>
>Also, if you are worried about these being used anywhere else, we can
>add:
>
>> +void set_module_text_rw(const struct module *mod)
>> +{
>> +	if (!rodata_enabled)
>> +		return;
>> +
>> +	mutex_lock(&module_mutex);
>> +	if (mod->state == MODULE_STATE_UNFORMED)
>
>	if (mod->state == MODULE_STATE_UNFORMED ||
>	    mod->state == MODULE_STATE_LIVE)
>
>As this will keep it from being used on modules that are executing.

Yeah, that'd be good. Aside from the big ftrace_module_init/enable
debate, I'm fine with this patch itself (with the change above), feel
free to include my Ack in case you want to include it with the rest of
the ftrace text_poke stuff.

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks,

Jessica

>> +		goto out;
>> +
>> +	frob_text(&mod->core_layout, set_memory_rw);
>> +	frob_text(&mod->init_layout, set_memory_rw);
>> +out:
>> +	mutex_unlock(&module_mutex);
>> +}
>> +
>> +void set_module_text_ro(const struct module *mod)
>> +{
>> +	if (!rodata_enabled)
>> +		return;
>> +
>> +	mutex_lock(&module_mutex);
>> +	if (mod->state == MODULE_STATE_UNFORMED ||
>> +	    mod->state == MODULE_STATE_GOING)
>> +		goto out;
>> +
>> +	frob_text(&mod->core_layout, set_memory_ro);
>> +	frob_text(&mod->init_layout, set_memory_ro);
>> +out:
>> +	mutex_unlock(&module_mutex);
>> +}
>> +
