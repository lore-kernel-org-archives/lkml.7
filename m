Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E372C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6F9216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfGEUt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:49:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39708 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:49:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so11062507wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 13:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhIelk8kmwXi71pyBfRqWH0t2v9nJ6L+6y0uXZsU6K0=;
        b=MQC1XBPJiOZRrcTuYMGejBDUmN1qRcs/AgSqce+wbYEU/HY+JiZOT8DsyGyDWXjEIf
         xA0PEbZUwcUqPnpHEqBsve9Tsl/7skpx64dzCYh3rCrhZ4Q7IQ26QSMLJDUm6CtfSzju
         efRH+KfUKTEIe2mpTBqvAU+GxmOqp8AgdMrc6MUAr0Y+bIUyyJeaY792+mkIlqOdpxms
         WBy2yESGxX2SsmGsAYrwYKNe+5PzmmdSMJTBFni/ZPm/r4hKlSzeLfRXFs7hcODWyKup
         5Hg3LDdg0XPJQ+2UBKpDAr3rGQTKLMjt5YUPDEcLep2E2hw8ncpCFJxVg0SY2o7FUdsy
         3CZg==
X-Gm-Message-State: APjAAAUj8cM4FK83t/rZJ2CBhLaqY080lmZyc/N6iWWY3i53DclDEb1B
        yJ6xgy251IT8kqrpeQ3qPdUhPw==
X-Google-Smtp-Source: APXvYqyALcPxgnAkktnAZVTurgvfW/15QdD/0aU8KKn+WOIH7hr9+txpv0/ftC/nyPNWd/uEzrhoQw==
X-Received: by 2002:adf:82a8:: with SMTP id 37mr5438446wrc.332.1562359797276;
        Fri, 05 Jul 2019 13:49:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423? ([2001:b07:6468:f312:19db:ad53:90ea:9423])
        by smtp.gmail.com with ESMTPSA id w20sm25963355wra.96.2019.07.05.13.49.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 13:49:56 -0700 (PDT)
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20190704155145.617706117@linutronix.de>
 <20190704155608.636478018@linutronix.de>
 <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
 <alpine.DEB.2.21.1907052213360.3648@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e9c8e2b-db98-6796-5241-7405f8c57564@redhat.com>
Date:   Fri, 5 Jul 2019 22:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907052213360.3648@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 22:25, Thomas Gleixner wrote:
> In practice, this makes Linux vulnerable to CVE-2011-1898 / XSA-3, which
> I'm disappointed to see wasn't shared with other software vendors at the
> time.

Oh, that brings back memories.  At the time I was working on Xen, so I
remember that CVE.  IIRC there was some mitigation but the fix was
basically to print a very scary error message if you used VT-d without
interrupt remapping.  Maybe force the user to add something on the Xen
command line too?

> The more interesting question is whether this is all relevant. If I
> understood the issue correctly then this is mitigated by proper interrupt
> remapping.

Yes, and for Linux we're good I think.  VFIO by default refuses to use
the IOMMU if interrupt remapping is absent or disabled, and KVM's own
(pre-VFIO) IOMMU support was removed a couple years ago.  I guess the
secure boot lockdown patches should outlaw VFIO's
allow_unsafe_interrupts option, but that's it.

> Is there any serious usage of virtualization w/o interrupt remapping left
> or have the machines which are not capable been retired already?

I think they were already starting to disappear in 2011, as I don't
remember much worry about customers that were using systems without it.

Paolo
