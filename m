Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3261C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24C72177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552508809;
	bh=0TQgH3cxUiVRtQU934+Bggt0qzA/A1qBONBdXm2VbfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nxk+fI81rlJy8Ad0zGQjRc1rIujmitcCE3urgEEeIDtqGU/aypiZVt+06386mMtwS
	 CdNLj7jRA8sErOO28q0br4xmK14u9/o/c7SjgMbrv/iSQ29OVcRFY3S2DENYXeALP+
	 rmfyqJjgw0KLobpF4sMxoP733YspwV4mGiN1DYRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfCMU0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35418 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfCMU0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:46 -0400
Received: by mail-yw1-f66.google.com with SMTP id s204so2595636ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4BTA8RcxLtQgy5J9A7f9y+R91YceT8xcqWtAvh+651A=;
        b=LRv5XA5Sz5wTH5ZuJ8BFn7or3p9bdLZ7DeAvndL+u/+HsGuu122J+KjFdKSBNAoVuh
         lYN6uoLgBvK6jg2vQiCPsmeaZc8UTCsqRH3JudUBLj2hIgpjGNYXlxo5Cj7snk5FoHeB
         ZYH8FB2+NckBNJDEGVWLb3v4Fc/Oz0Qow7JoW7LnereeBqALUlzgaE+a+dQzy88/BluK
         34WTjZqez+t7JNd0X83Z18vdsl8ygyIn6T0I3nTDFKXGYO7erdI23eASAh8djUuK/Loo
         W3/ZH9FreIA8I0rtZnPXf/CgOXfRUcIyIJ2+4x16z3ABoj8JojVjAtLaugzlXXwASEND
         B3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4BTA8RcxLtQgy5J9A7f9y+R91YceT8xcqWtAvh+651A=;
        b=h55ktT+8ImC1go2YYFzEUhxPc2lJQ+uRz/q3xSeMOtlgHoFQkZWoZ/1LVnMwV63Kgp
         P0e/Uj57oHCtCwNcjmJ9w+IchB/2pDM+lr6IxtYa9Djx2dhm9knpqlFek9tVX3qxA1Yy
         uMbNJLmuje8RcCJ3vzNxbbjnWPshoz3eDRi58K/6aQZlgQWksnIGNy4VfjfZWoef81Mj
         9hW3Ml5wiHQRm46oBMWINN4ZpEZUXipPoBsjsq0TQ7bjImnyr3oip1Y553N/gnf3z4E1
         C5NnhN+zRJkVP326fvjXesaFYvISsBb9X9a9Zmit/AIiBNxmNoiGvu4bAZ5ZgyIgdItY
         hPBA==
X-Gm-Message-State: APjAAAW93+RgCRz9oyztMt6LPLky9/x81xCeR31k1o+DZa6opxz7/h6a
        MqilK+J/hEZnLkyXA+sYujA=
X-Google-Smtp-Source: APXvYqzZy23FAqs3jC0gdxDo0tAAc18vR7HuRKSiu8DWXVCH+tEAvu8BtOX9I4w4eeMqcxrasJfuFg==
X-Received: by 2002:a81:c8a:: with SMTP id 132mr35927178ywm.269.1552508804792;
        Wed, 13 Mar 2019 13:26:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::90f5])
        by smtp.gmail.com with ESMTPSA id 145sm289569ywj.9.2019.03.13.13.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:26:43 -0700 (PDT)
Date:   Wed, 13 Mar 2019 13:26:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Barret Rhoden <brho@google.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eial Czerwacki <eial@scalemp.com>,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Message-ID: <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 13, 2019 at 03:40:04PM -0400, Barret Rhoden wrote:
> Are there any other alternatives?  Not using static SRCU in any code
> that could be built as a module seems a little harsh.

Yes, allocate the srcu dynamically on module init and destroy on
module exit.  That's how the other similar case got solved too.  We
can't keep bumping up reserved size by the number of static SRCUs in
modules.  It's mostly there to make trivial small things easier.  We
don't lose anything meaningful by allocating srcu dynamically.

Thanks.

-- 
tejun
