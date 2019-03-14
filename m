Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C63AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E62A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552584987;
	bh=1R+HX5Qp/bJC5v5JUlHANdfnNNQDFjlMQpO4k56qxcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vBmJiOJB0YA1Au/7OzaXd2kPXvyE6WI6YbGkP1AeE1T1zrdnNA8fH936lKfkizktK
	 kAeNR6tA8mAubtJe/sdt+ADbHnozHjGFahzhffoQg/24DD5Y47U2YUJEJUSA7T4q4x
	 mR7VKeM1NFgPepn6r828a+ww1G4ZuZt24vqdbxH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfCNRgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:36:25 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43788 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCNRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:36:25 -0400
Received: by mail-yw1-f68.google.com with SMTP id j66so5074142ywc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AkdrWCQ36Hh7Rd9w17uBOEclnl3dzjlu5HlHZoqlyW0=;
        b=rWCZ27O6Da2V8NIrsmBI0/ABVWHbttX637S/uGr/PHuCPK9n+0Hmmb9TF5NZYvSY/S
         JQoRQ0hbyMf1JiImPCRwLPMVvMgkTGahziUAu1ma37VG/bduH+pK3hkgLqTXQwd/u1Wx
         vIfDTR961k9RPbRMGmtSfUVHD/W2COzNduZL9ZDBOHM57P/atMwsx80BLGLLnbNwr0+b
         Q6ygDnddVq5OSitk0CO/hAoZoq8YZ2+exCCIyoc89XCoBHoio3f3GrV2Dcqzp88f2arL
         sAlK/kY5Coa9rzzr/6a8pKDDmKWi/lRBmY8HZnCsyMVzCsWMuXutC5D/e4iSi7WC/NyI
         Fkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AkdrWCQ36Hh7Rd9w17uBOEclnl3dzjlu5HlHZoqlyW0=;
        b=lmYJpUEKF3eCRK1QSu4GnTEWAZIkPj9ixz4HCfPpqBwY1pibZKlFgtmenqJg5GjKnz
         har47QuWjCIYAQqvsVBBSvC2oueelmTjxSh+JJ19NscRUibCuAu3z6Nq7jzro2nfhl08
         Y02blfphdy3qxXy4CWRR8HFCR3+p2oLDqfSIdOQb4KQLACi0dHvQOfPE5j+b34xdct2h
         0hciIKmNNdP6rwymjOjXKFAo8nQAgCFCK2t3RQ1px/Z3KlU/Y015MOL04IuAbj9YNBrI
         R2Ww3OYc48j+NxwbjLNKezSfDY1gfkZ1fhIMjYuvLzfyGqP+cSr4cCpDAyH2gliTyBSU
         U8pg==
X-Gm-Message-State: APjAAAXRkutpY6r/qmIyiUJrwRDMuN0WfRy03IoKcANSpaArH2edjDS2
        CDzUMpiMW5iREKTy0FmoTS8=
X-Google-Smtp-Source: APXvYqyDU1lW9chX7dvyiejqye2kzCN8QtvDqTEl3ByZjZ8bq18HoHSVa2D0o4dCtU/g2iQtzBD0lA==
X-Received: by 2002:a25:bbc3:: with SMTP id c3mr41255942ybk.459.1552584983145;
        Thu, 14 Mar 2019 10:36:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:356b])
        by smtp.gmail.com with ESMTPSA id q1sm3319381ywg.28.2019.03.14.10.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 10:36:21 -0700 (PDT)
Date:   Thu, 14 Mar 2019 10:36:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Barret Rhoden <brho@google.com>,
        Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eial Czerwacki <eial@scalemp.com>,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Message-ID: <20190314173619.GL50184@devbig004.ftw2.facebook.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
 <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
 <20190313212255.GY13351@linux.ibm.com>
 <20190313212912.GK50184@devbig004.ftw2.facebook.com>
 <20190313231155.GC13351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313231155.GC13351@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:11:55PM -0700, Paul E. McKenney wrote:
> commit 34f67df09cc0c6bf082a7cfca435373caeeb8d82
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Wed Mar 13 16:06:22 2019 -0700
> 
>     srcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
>     
>     Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module
>     requires that the size of the reserved region be increased, which is
>     not something we want to be doing all that often.  Instead, loadable
>     modules should define an srcu_struct and invoke init_srcu_struct()
>     from their module_init function and cleanup_srcu_struct() from their
>     module_exit function.  Note that modules using call_srcu() will also
>     need to invoke srcu_barrier() from their module_exit function.
>     
>     This commit enforces this advice by refusing to define DEFINE_SRCU()
>     and DEFINE_STATIC_SRCU() within loadable modules.
>     
>     Suggested-by: Barret Rhoden <brho@google.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

Looks-great-to-me-by: Tejun Heo <tj@kernel.org>

Thanks. :)

-- 
tejun
