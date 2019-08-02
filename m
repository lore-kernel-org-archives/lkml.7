Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723272173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392275AbfHBVfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:35:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51091 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392168AbfHBVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:35:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so69239140wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 14:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAdpsMp0JwteBK+W0fAmX6K6NSq1AjtuMfd/ePK3wqA=;
        b=AqXiSWMMowI13WnPKu7rOP5N2dnHQGrjCSQqKnw0wb/H4PqfBOQl2DbS9syzgVU3J7
         U/fpCXLl28gyKfMXz8oh2NKMDwqYfohNaj8NAtLidfaZZbVR8COcaWJLLX4Vs3MVrp3z
         Fek5ODHD3dEaxOdAV+8RmXBuB0CFj6r7lWADwksY7/t7w8nRp06Xzviu9nxgojKve0hi
         y3QO3rIUj3UlMFj8cnABQ9wu3jhOiMcNP7N7wETj+S71yc2EYY4xyXp44l40erYkUWtG
         R6Uoxiw/4YcVAEYcTe6xE5TWtE0wwyZunbT3ICIWWJh/h6TLMax/2j/u3VXOQ3h2F3FQ
         83HQ==
X-Gm-Message-State: APjAAAXM+Il+B4bi6d78BSdyup8ifcsBzO7U+aGc1bga4WBiOXaYvSG+
        +AZFCUHEWHEkYNUCUR5n5GanGA==
X-Google-Smtp-Source: APXvYqwqOtCPXQm2nTlhVq6wHxd0GIQxEdD61fQyKo6RtYwTbatiL3/CMTZFyDXKR7A0RpuJ5jHaVw==
X-Received: by 2002:a05:600c:240e:: with SMTP id 14mr5682450wmp.30.1564781737472;
        Fri, 02 Aug 2019 14:35:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id r123sm72240591wme.7.2019.08.02.14.35.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 14:35:36 -0700 (PDT)
Subject: Re: [patch 2/5] x86/kvm: Handle task_work on VMENTER/EXIT
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, kvm@vger.kernel.org,
        Radim Krcmar <rkrcmar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <20190801143250.370326052@linutronix.de>
 <20190801143657.887648487@linutronix.de> <20190801162451.GE31538@redhat.com>
 <alpine.DEB.2.21.1908012025100.1789@nanos.tec.linutronix.de>
 <20190801213550.GE6783@linux.intel.com>
 <alpine.DEB.2.21.1908012343530.1789@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908012345000.1789@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c8294b01-62d1-95df-6ff6-213f945a434f@redhat.com>
Date:   Fri, 2 Aug 2019 23:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908012345000.1789@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 23:47, Thomas Gleixner wrote:
> Right you are about cond_resched() being called, but for SRCU this does not
> matter unless there is some way to do a synchronize operation on that SRCU
> entity. It might have some other performance side effect though.

I would use srcu_read_unlock/lock around the call.

However, I'm wondering if the API can be improved because basically we
have six functions for three checks of TIF flags.  Does it make sense to
have something like task_has_request_flags and task_do_requests (names
are horrible I know) that can be used like

	if (task_has_request_flags()) {
		int err;
		...srcu_read_unlock...
		// return -EINTR if signal_pending
		err = task_do_requests();
		if (err < 0)
			goto exit_no_srcu_read_unlock;
		...srcu_read_lock...
	}

taking care of all three cases with a single hook?  This is important
especially because all these checks are done by all KVM architectures in
slightly different ways, and a unified API would be a good reason to
make all architectures look the same.

(Of course I could also define this unified API in virt/kvm/kvm_main.c,
so this is not blocking the series in any way!).

Paolo
