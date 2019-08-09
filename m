Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250DBC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8D920B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406916AbfHIM7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:59:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38225 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:59:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so98159108wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 05:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HLXW1P5skFobhHJ4dzap2nkO3+yr55pf93FGl2qv6xQ=;
        b=XNvThaRPky4PqoMpVV8jybvS5kmKVEOGUR6l7diDt48QdX42Uah5hpdFEQT04I8/a5
         G54iAcbeSJQKXs3qYOt3IUHzYPyn/B7si5FeVqb7FLvMqtFeBtD3qJj7lp22q9HNooDm
         8nWrMEVQf1ShYzWqTNnMIFZGKl68NhK/k35BcfDjYDsek0q0QrVZq0iVPdmO3FYHXowT
         A9JfPBpQR51NC9DuU87Hs2w4Cj4p0xUPiUtNusjsocWU87xE9+KnejYCp6nmlx5Rze06
         /mY6q2UTJwGbS4+cLidazk2kaSMskZjezf4cr3gnq1LkkfIhsYSaMZfhnLUY9mGXR224
         jjxw==
X-Gm-Message-State: APjAAAVIItVlBnp80WiCuJSrsPG+sX1+e3qWeKBACjPBnvCl4N5hAs9S
        Doy9ooBrIc2v6eYLOQQnYPI=
X-Google-Smtp-Source: APXvYqyIVW1A3tBwmbL/e9b0pqYPlLzQzGXMsheVZ0rifSnSNXl//E7WhyWSv0BVbkEkpG/qb1Qa6Q==
X-Received: by 2002:a5d:5041:: with SMTP id h1mr11465178wrt.30.1565355547488;
        Fri, 09 Aug 2019 05:59:07 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id e10sm16241211wrn.33.2019.08.09.05.59.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 05:59:06 -0700 (PDT)
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
 <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
 <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com>
 <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
 <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com>
 <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABtBtKaXJpIFNsYWJ5
 IDxqc2xhYnlAc3VzZS5jej6JAjgEEwECACIFAk6S6NgCGwMGCwkIBwMCBhUIAgkKCwQWAgMB
 Ah4BAheAAAoJEL0lsQQGtHBJgDsP/j9wh0vzWXsOPO3rDpHjeC3BT5DKwjVN/KtP7uZttlkB
 duReCYMTZGzSrmK27QhCflZ7Tw0Naq4FtmQSH8dkqVFugirhlCOGSnDYiZAAubjTrNLTqf7e
 5poQxE8mmniH/Asg4KufD9bpxSIi7gYIzaY3hqvYbVF1vYwaMTujojlixvesf0AFlE4x8WKs
 wpk43fmo0ZLcwObTnC3Hl1JBsPujCVY8t4E7zmLm7kOB+8EHaHiRZ4fFDWweuTzRDIJtVmrH
 LWvRDAYg+IH3SoxtdJe28xD9KoJw4jOX1URuzIU6dklQAnsKVqxz/rpp1+UVV6Ky6OBEFuoR
 613qxHCFuPbkRdpKmHyE0UzmniJgMif3v0zm/+1A/VIxpyN74cgwxjhxhj/XZWN/LnFuER1W
 zTHcwaQNjq/I62AiPec5KgxtDeV+VllpKmFOtJ194nm9QM9oDSRBMzrG/2AY/6GgOdZ0+qe+
 4BpXyt8TmqkWHIsVpE7I5zVDgKE/YTyhDuqYUaWMoI19bUlBBUQfdgdgSKRMJX4vE72dl8BZ
 +/ONKWECTQ0hYntShkmdczcUEsWjtIwZvFOqgGDbev46skyakWyod6vSbOJtEHmEq04NegUD
 al3W7Y/FKSO8NqcfrsRNFWHZ3bZ2Q5X0tR6fc6gnZkNEtOm5fcWLY+NVz4HLaKrJuQINBE6S
 54YBEADPnA1iy/lr3PXC4QNjl2f4DJruzW2Co37YdVMjrgXeXpiDvneEXxTNNlxUyLeDMcIQ
 K8obCkEHAOIkDZXZG8nr4mKzyloy040V0+XA9paVs6/ice5l+yJ1eSTs9UKvj/pyVmCAY1Co
 SNN7sfPaefAmIpduGacp9heXF+1Pop2PJSSAcCzwZ3PWdAJ/w1Z1Dg/tMCHGFZ2QCg4iFzg5
 Bqk4N34WcG24vigIbRzxTNnxsNlU1H+tiB81fngUp2pszzgXNV7CWCkaNxRzXi7kvH+MFHu2
 1m/TuujzxSv0ZHqjV+mpJBQX/VX62da0xCgMidrqn9RCNaJWJxDZOPtNCAWvgWrxkPFFvXRl
 t52z637jleVFL257EkMI+u6UnawUKopa+Tf+R/c+1Qg0NHYbiTbbw0pU39olBQaoJN7JpZ99
 T1GIlT6zD9FeI2tIvarTv0wdNa0308l00bas+d6juXRrGIpYiTuWlJofLMFaaLYCuP+e4d8x
 rGlzvTxoJ5wHanilSE2hUy2NSEoPj7W+CqJYojo6wTJkFEiVbZFFzKwjAnrjwxh6O9/V3O+Z
 XB5RrjN8hAf/4bSo8qa2y3i39cuMT8k3nhec4P9M7UWTSmYnIBJsclDQRx5wSh0Mc9Y/psx9
 B42WbV4xrtiiydfBtO6tH6c9mT5Ng+d1sN/VTSPyfQARAQABiQIfBBgBAgAJBQJOkueGAhsM
 AAoJEL0lsQQGtHBJN7UQAIDvgxaW8iGuEZZ36XFtewH56WYvVUefs6+Pep9ox/9ZXcETv0vk
 DUgPKnQAajG/ViOATWqADYHINAEuNvTKtLWmlipAI5JBgE+5g9UOT4i69OmP/is3a/dHlFZ3
 qjNk1EEGyvioeycJhla0RjakKw5PoETbypxsBTXk5EyrSdD/I2Hez9YGW/RcI/WC8Y4Z/7FS
 ITZhASwaCOzy/vX2yC6iTx4AMFt+a6Z6uH/xGE8pG5NbGtd02r+m7SfuEDoG3Hs1iMGecPyV
 XxCVvSV6dwRQFc0UOZ1a6ywwCWfGOYqFnJvfSbUiCMV8bfRSWhnNQYLIuSv/nckyi8CzCYIg
 c21cfBvnwiSfWLZTTj1oWyj5a0PPgGOdgGoIvVjYXul3yXYeYOqbYjiC5t99JpEeIFupxIGV
 ciMk6t3pDrq7n7Vi/faqT+c4vnjazJi0UMfYnnAzYBa9+NkfW0w5W9Uy7kW/v7SffH/2yFiK
 9HKkJqkN9xYEYaxtfl5pelF8idoxMZpTvCZY7jhnl2IemZCBMs6s338wS12Qro5WEAxV6cjD
 VSdmcD5l9plhKGLmgVNCTe8DPv81oDn9s0cIRLg9wNnDtj8aIiH8lBHwfUkpn32iv0uMV6Ae
 sLxhDWfOR4N+wu1gzXWgLel4drkCJcuYK5IL1qaZDcuGR8RPo3jbFO7Y
Message-ID: <b7c3809f-cdea-03f0-09f8-a47e6f304ec1@suse.cz>
Date:   Fri, 9 Aug 2019 14:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 08. 19, 14:54, Thomas Gleixner wrote:
> Some newer machines do not advertise legacy timers. The kernel can handle
> that situation if the TSC and the CPU frequency are enumerated by CPUID or
> MSRs and the CPU supports TSC deadline timer. If the CPU does not support
> TSC deadline timer the local APIC timer frequency has to be known as well.
> 
> Some Ryzens machines do not advertize legacy timers, but there is no
> reliable way to determine the bus frequency which feeds the local APIC
> timer when the machine allows overclocking of that frequency.
> 
> As there is no legacy timer the local APIC timer calibration crashes due to
> a NULL pointer dereference when accessing the not installed global clock
> event device.
> 
> Switch the calibration loop to a non interrupt based one, which polls
> either TSC (frequency known) or jiffies. The latter requires a global
> clockevent. As the machines which do not have a global clockevent installed
> have a known TSC frequency this is a non issue. For older machines where
> TSC frequency is not known, there is no known case where the legacy timers
> do not exist as that would have been reported long ago.
> 
> Reported-by: Daniel Drake <drake@endlessm.com>
> Reported-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> 
> Note: Only lightly tested, but of course not on an affected machine.

Thanks, I will make them test the patch and let you know.

-- 
js
suse labs
