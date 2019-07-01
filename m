Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943CDC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7506D21721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfGARaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:30:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33495 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbfGARay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:30:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so540112wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+/Xi3dP2as3IG528X+Pko9xkFRs702hbLeYHSx7qX+o=;
        b=kUA/0jpBdklqnGbi0I9WYAL5YfrlsJ1K7KZZztrb6dgwwR8m6Bbmjhcett7mKxHHAm
         zC8jIhoaDn46o7dSDqR09CSuGspSM9ditwfPHoTgIKQRqrx4yowTqi9oFp26Rc2JjYpc
         3788lpoGX9NnAeR8YfmmgTx+dZMDheiiv5yhQfFGlz7xsrVNk+Edvtk8nYFhPJwnM4z5
         J5DgfOqeQYJMQ7dnng5SmR65Am+tCh2SxJbew98+/7SI0aAvyCDASJwSXu5aPn8v6bAk
         w85Nz1JqTTvcg5l6Y3DRGPyUKqE/ZNV8Tkj+zpjG6we6wlQbV31dIUTS6cOm1E00Rev5
         y51Q==
X-Gm-Message-State: APjAAAX/3KV/DHHrVjlAwJ3aJOd77f8A3CB9GCtiKwkDI+9SFoXMnU9A
        Ws5rcLgiIpTaL7A3j7a1a0DQLw==
X-Google-Smtp-Source: APXvYqzfzStGPlDN+EuoDcTflU6PfgBcqP3b54klRiFX0XlkceYabKm6eOHRIN5/uLkO+TnjOGYmrQ==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr276316wmb.112.1562002252781;
        Mon, 01 Jul 2019 10:30:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b8:794:183e:9e2a? ([2001:b07:6468:f312:b8:794:183e:9e2a])
        by smtp.gmail.com with ESMTPSA id t140sm664628wmt.0.2019.07.01.10.30.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 10:30:52 -0700 (PDT)
Subject: Re: [Kernel BUG?] SMSW operation get success on UMIP KVM guest
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Li Wang <liwang@redhat.com>, tglx@linutronix.de,
        kernellwp@gmail.com, ricardo.neri@intel.com, pengfei.xu@intel.com,
        LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ping Fang <pifang@redhat.com>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
 <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
 <20190701145308.GA19368@ranerica-svr.sc.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cde7f924-10c9-7ffc-d323-b786240244b3@redhat.com>
Date:   Mon, 1 Jul 2019 19:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701145308.GA19368@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/19 16:53, Ricardo Neri wrote:
>>
>> (*) before the x86 people jump at me, this won't happen unless you
>> explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
>> incorrect emulation of SMSW when CR4.UMIP=1 is why.
> Paolo, what do you mean by the incorrect emulation of SMSW?

When KVM tries to emulate UMIP on a system that doesn't have it, SMSW
won't cause a #GP.  The processor is simply not able to trap to the
hypervisor on SMSW (unlike SGDT/SIDT/SLDT/STR), so it's impossible to do
better.

Paolo
