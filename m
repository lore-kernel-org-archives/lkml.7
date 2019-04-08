Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78185C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8B62147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDHN6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDHN6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:58:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71ACE307D976;
        Mon,  8 Apr 2019 13:58:30 +0000 (UTC)
Received: from [10.43.17.46] (unknown [10.43.17.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE46B60BE5;
        Mon,  8 Apr 2019 13:58:29 +0000 (UTC)
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
From:   Denys Vlasenko <dvlasenk@redhat.com>
To:     sedat.dilek@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com>
Message-ID: <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
Date:   Mon, 8 Apr 2019 15:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 08 Apr 2019 13:58:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 3:56 PM, Denys Vlasenko wrote:
> I propose to change section name, append _module_ name and optionally
> a comment why this is done:
> 
>   /* NB: section is mergeable, all elements must be aligned 16-byte blocks */
> +/* There is more than one object in this section, let's use module name
> +   as unique suffix */

Probably not clear enough... maybe this is better:

+/* There is more than one object in this section, let's use module name
+   instead of object name as unique suffix */
-.section        .rodata.cst16, "aM", @progbits, 16

and do not use '-' in the name, replace with '_':

+.section        .rodata.cst16.cast6_avx_x86_64_asm_64, "aM", @progbits, 16


