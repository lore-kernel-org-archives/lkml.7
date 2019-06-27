Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C70FC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E664D2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561670032;
	bh=dsbUT9a+ExxoJeWmOE/PV47vOSsC/fbPWcb5Oe/yHtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eaZ5+ggnXe082tLWUwDlM9r9Nv+P9YPEPijeuShIsM140mBFcaaDc/BvHZ4u/Bph2
	 0udzKNdDDQPL0e89piOusrrKQ8t7F0fP8AAqNiJx6CRwWJ2DFhcY4lhIAW1bRcKGKD
	 f2SWcQDY8oIaSUJ/0c4LPfI/FeS7Mde1lVUxT3ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfF0VNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:13:50 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45758 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfF0VNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:13:39 -0400
Received: by mail-qk1-f173.google.com with SMTP id s22so3027669qkj.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IRnpl/Oqutc0IjJOuUHf+A1pOSjmBe0PXuqMHR+0BaA=;
        b=ZwAAZRQTAzHyv3AIjz/KQ9FAKQNWbJIgePNyhvkgnwgZG1J4iMleRqf6cATK8s5B5m
         KVar666XTDdkDBXZgrMOyIbfE3N3WQZ2EPF6Nh0xRMML7Un/nVqPiXT+YRge0Ch0XN/k
         VgWuE/OhLEuGBI2EeIDSdDsad6JS1bzXEYS5l9IQ/MHG+WV37g0TKSsWOXTA4yhNwSkY
         nJNSc2+gzJjDdG0txn6S9431do5Uo9/RprD8I/hl3N7XMLTChpHoXeDvzegf1VWPKECD
         Pv138S083ZGKQZ3oUOSNQvHW7VwILTa0mxn/dQE6jP9mJYn/vj86tdiYSKJwbInYPBTm
         TqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRnpl/Oqutc0IjJOuUHf+A1pOSjmBe0PXuqMHR+0BaA=;
        b=a+2V8zxgAIa5O/UbvwqSRGSUjpxRjp9AxfDHzO8HQK3PqWSliYvEPKbY9iIBZg3nGr
         FX46LLj5fjBkRDsUbxHKAY78QVCIN6kMRhTQ5MnGRPTKK3yHT3T6SKThRwzo+/6MSop/
         a2Oslacx3aXj6GwJNemC9GRfh+Gh0b1EQjHXV5E4S5VspjCq2aYPdCH9ZxA5HEjWpxz0
         qSLZa8E44P8iiIj3VHuBH/21rX07ZgPkM/j3QYyP3oPYyZAsMuUnAUj2N1cuWu45CTJC
         PK9Z7Mt8HNamszuF2v5JpJjraXpD1B3ZrIKzxNUAsT5+z/Rc7BGnSgfsgRIyug0yo42a
         9i+g==
X-Gm-Message-State: APjAAAVNbnVapuzltx4hgomoz9IwMu1VdHiVlRfcPmbP2WYf58s5lNhj
        8HM3kJBmIcSDAgp56/ZFN6vSS828
X-Google-Smtp-Source: APXvYqwSY2QZ+XpNcOpF1oe1NCLpZX2v22yL3J+PbRKHtycY+bHF2AAnCvf4StRT3dS53214aWpINA==
X-Received: by 2002:a37:9144:: with SMTP id t65mr5625561qkd.367.1561670017973;
        Thu, 27 Jun 2019 14:13:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5a51])
        by smtp.gmail.com with ESMTPSA id z1sm112747qke.122.2019.06.27.14.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:13:37 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:13:35 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: your mail
Message-ID: <20190627211335.GX657710@devbig004.ftw2.facebook.com>
References: <20190626145238.19708-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626145238.19708-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:52:36PM +0200, Sebastian Andrzej Siewior wrote:
> A small series of tiny cleanups.

Applied 1-2 to wq/for-5.3.

Thanks.

-- 
tejun
