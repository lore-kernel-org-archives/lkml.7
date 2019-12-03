Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233CFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD62720661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575396844;
	bh=gmQ1MBz3ogQCFayy3lDzbjbIGsXScv5OiRm6emR37BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OfuCANHm2a72KuBj3nU8BdqE7Ymt8fn2NZSDDHpAvHBsCC1w9Vd/TZ8YZDDAzgerM
	 RnxkWk4FKS6TfwuvaA9b1zgLTjIb/t2oVdYlxIRaCaLMcHjKMjBSl0TjnQ19nJzSv0
	 bNLShXyGR8MdyjxtLu458haEnMsO7bNJz2cOQ7C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLCSOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:14:03 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:35394 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:14:03 -0500
Received: by mail-qk1-f177.google.com with SMTP id v23so4410352qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bSoHGU34HhH7Z+cwNwbqJOETIDv3oltvGGySq0SCzhQ=;
        b=iHy/sGeyK12CIPnaj8SII6nIAuSPCbRVPhXvxICLCRrhNxMyFlJQVRKeyz5Nv0INw2
         1w+kXcdEfW4Q7khRVUBvHWlK3FkSfbVHGI4NVziTFs+nfvvWfShJw3+n0zUEsPwzx4+U
         Nj1QsOja72swBKbW8yn608+KLPRJ2JilANI1W+IO4uC3BRj95gR3fhXk4UoDYoGxffQh
         HDoCKsgoSZOnU581QZi82q8DXO/PYKFJ0Ij3/HosiGY7hFmPzeEH3ydQUtKKPKfkMYeL
         FZrJ6vfwt/NmhiKJdXPZzCDOWX/pmHT485XKp8rAF1lu0xTjUrfKbIY39tpQEbvAm1fS
         rwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSoHGU34HhH7Z+cwNwbqJOETIDv3oltvGGySq0SCzhQ=;
        b=KAf8Xh5H3H8TUE/jOOoP8tQm5lKTcVDDGjGmepbPeq4gQuFRoryZldmIkr0T5+i0ji
         Pb7wwPI9Ibga7j2blEL6RM3LCndrb+4nqTHlMpD+baNxqs7HK6S9eAAua2EdHvzERXpf
         R6TUKuuJz01UgI0fyIOzHUORqUfm0nP7MKKqh4e4UGkQl1br3cAJpQkoEnMoHOnUFKlD
         9hcKQTtp4mTOeZVNJEiLA6EVWsKDWNAYL3deXel71OvqiDS9/ezT+0QqwPksoabiwfmu
         NXGJnLGDcgt24sq29wnbWd+j6C7RGcSbpAm8jq/aAatfvXBVzz5l2nEyZT9SGiBW3cCc
         WlGQ==
X-Gm-Message-State: APjAAAUHIAOKpQMtDKntCmwdkaxcMK16mNANYP7NVgxRC4iVnIusx3Uc
        G7WHEP0t2s4CK2iJ7oJU2Ho=
X-Google-Smtp-Source: APXvYqx9F8vgJ98Y6VUDWc3ikjyGciCgOn/OZuacFTA+WkEoOpoClYPDg7xs/9DjgsCH3mP1GtfGEQ==
X-Received: by 2002:a05:620a:543:: with SMTP id o3mr6659927qko.354.1575396842162;
        Tue, 03 Dec 2019 10:14:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:6ede])
        by smtp.gmail.com with ESMTPSA id w76sm2158089qkb.8.2019.12.03.10.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 10:14:01 -0800 (PST)
Date:   Tue, 3 Dec 2019 10:13:59 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191203181359.GD2196666@devbig004.ftw2.facebook.com>
References: <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191202233944.GY2889@paulmck-ThinkPad-P72>
 <20191203100010.GI2827@hirez.programming.kicks-ass.net>
 <20191203174547.GG2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203174547.GG2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul.

On Tue, Dec 03, 2019 at 09:45:47AM -0800, Paul E. McKenney wrote:
> Good point, and yes, you have told me this before.
> 
> Furthermore, in all of these cases, the process was supposed to be
> running on CPU 0, which cannot be taken offline on any of the systems
> under test.  Which is leading me to wonder if the workqueue CPU-online
> notifier is sometimes moving more kthreads to the newly onlined CPU than
> it is supposed to.  Tejun, could that be happening?

All the warnings that you posted are from rescuers and they jump
around different cpus so that it's on the correct cpu for the specific
work item being rescued.  This is a completely separate thing from the
usual worker management and rescuers don't interact with hot[un]plug
callbacks in any way.  I think something like the following is what's
happening:

* A work item is queued to CPU5 but it hasn't been dispatched for a
  bit so rescuer gets summoned.  The rescuer executes the work item
  and stays there.

* CPU 5 goes down.  The rescuer is asleep and doesn't get affected.

* CPU 5 is coming up.  It has online set but the stopper hasn't been
  enabled yet.

* A work item was queued on CPU0 but hasn't been dispatched for a
  bit, so rescuer is woken up.

* Rescuer wakes up fine on CPU5 as it's online.  Seeing the CPU0 work
  item, the rescuer tries to migrate to CPU0 by calling
  set_cpus_allowed_ptr(); however, stopper isn't up yet and migration
  doesn't actually happen.

* Boom.  Rescuer is now executing CPU0 work item on CPU5.

Thanks.

-- 
tejun
