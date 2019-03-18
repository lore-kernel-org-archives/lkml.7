Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67910C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3106921734
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="hiP3Cy11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCRISz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:18:55 -0400
Received: from www.scalemp.com ([169.44.78.149]:45930 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfCRISv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CIQLRgXhEYZ+LxBRASvoXCmRz/2o6wCcqEisJk24XyE=; b=hiP3Cy110mH6C+q7Qlpkid1uYT
        hyAPCrqNzaDxADwOl3rVgLBHjZijHdbE7VFTtOBvk1wBFTXbgIp44LUaXXryxmcDZ48eAiihPjqh7
        jwMqKbHDB3hDmIW1fJTKFBbamDvMNuC7rPoxD4NoYRNjpqG8Y9KV7goTBI/RrTscKyKU=;
Received: from bzq-80-45-146.static.bezeqint.net ([82.80.45.146]:30257 helo=[10.100.0.120])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1h5nTu-000gmN-JY; Mon, 18 Mar 2019 04:18:50 -0400
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
To:     paulmck@linux.ibm.com
Cc:     Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>,
        Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Shai Fultheim <shai@scalemp.com>, Oren Twaig <oren@scalemp.com>
References: <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
 <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
 <20190313212255.GY13351@linux.ibm.com>
 <20190313212912.GK50184@devbig004.ftw2.facebook.com>
 <20190313231155.GC13351@linux.ibm.com>
 <20190314173619.GL50184@devbig004.ftw2.facebook.com>
 <20190314221943.GQ4102@linux.ibm.com>
From:   Eial Czerwacki <eial@scalemp.com>
Organization: ScaleMP
Message-ID: <f44f1d5f-67b4-6ffd-80c1-28c48828f85b@scalemp.com>
Date:   Mon, 18 Mar 2019 10:18:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314221943.GQ4102@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Paul,

On 3/15/19 12:19 AM, Paul E. McKenney wrote:
> On Thu, Mar 14, 2019 at 10:36:19AM -0700, Tejun Heo wrote:
>> On Wed, Mar 13, 2019 at 04:11:55PM -0700, Paul E. McKenney wrote:
>>> commit 34f67df09cc0c6bf082a7cfca435373caeeb8d82
>>> Author: Paul E. McKenney <paulmck@linux.ibm.com>
>>> Date:   Wed Mar 13 16:06:22 2019 -0700
>>>
>>>     srcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
>>>     
>>>     Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module
>>>     requires that the size of the reserved region be increased, which is
>>>     not something we want to be doing all that often.  Instead, loadable
>>>     modules should define an srcu_struct and invoke init_srcu_struct()
>>>     from their module_init function and cleanup_srcu_struct() from their
>>>     module_exit function.  Note that modules using call_srcu() will also
>>>     need to invoke srcu_barrier() from their module_exit function.
>>>     
>>>     This commit enforces this advice by refusing to define DEFINE_SRCU()
>>>     and DEFINE_STATIC_SRCU() within loadable modules.
>>>     
>>>     Suggested-by: Barret Rhoden <brho@google.com>
>>>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>>
>> Looks-great-to-me-by: Tejun Heo <tj@kernel.org>
> 
> Applied.  ;-)
> 
> 							Thanx, Paul
> 
>> Thanks. :)
>>
>> -- 
>> tejun
>>
> 
> 

when can this patch be found in the kernel mainline git repo? I'd like
to test and see if the patch that started this mail thread still occurs.

Thanks,

Eial.
