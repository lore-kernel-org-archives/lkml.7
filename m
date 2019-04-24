Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51524C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACEF218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403782AbfDXRbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:31:22 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:45930 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403772AbfDXRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:13 -0400
Received: by mail-qk1-f172.google.com with SMTP id d5so9069955qko.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=eTLISjJwUHw4lGNfrwxk/71GLv53QQdcgiYYf8SrSz8=;
        b=KgF2pdGj/QEuEf013Jo5onW+us0ICM2n7HfyfssCKgSYq5DN80er3tPSO29SCjQNfY
         4/CIgXeAw0S4NXwWifJXqyazdrzTdkCRWTsJNG/oGzByPHO+SUEPBq0T1aUUMcc8rPJ7
         rJabNNPUYe7Z5jeQkHTvMLCXcpjbztXkQ/M56z+rNMSq3zeekT6j+dC1DQxGQBlR1+8K
         JyzEwWI9miUzHkq/2pkRga+a0kT0i4uy2iX7EDjECJohgGT8iOw1a+BshjzWdYu/f3Md
         t+dxQFr+nbjq8TPz4mekub6uRsDAye68ME5mdnWc72uGSxeKb6Tjdh6tim3vxbnpLBEQ
         vKRg==
X-Gm-Message-State: APjAAAXIRtgPcZJ3GbmVgJFGL5M856kevNSySjDy7/Wa9jzuFemwdRAy
        +JblqNOy7Mmkgok+k5sJs8A2AA==
X-Google-Smtp-Source: APXvYqznV0AJ6erOiLOlUEASHstK+DGsKzve9fJWwdmDag6YPj1a2AtQeaFI0O3mX9Arf5lCDAh45w==
X-Received: by 2002:a37:7d87:: with SMTP id y129mr23981785qkc.43.1556127072054;
        Wed, 24 Apr 2019 10:31:12 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id y7sm6584776qki.14.2019.04.24.10.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 10:31:11 -0700 (PDT)
Message-ID: <389c7b3117168209fb4760537d908a477446d013.camel@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Wed, 24 Apr 2019 13:31:09 -0400
In-Reply-To: <20190404141724.GJ141706@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
         <20190321224819.GK251185@google.com> <20190322113015.GM251185@google.com>
         <20190404141724.GJ141706@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any update on this? This has been waiting for a while now

On Thu, 2019-04-04 at 09:17 -0500, Bjorn Helgaas wrote:
> [+cc Hans, author of 0b2fe6594fa2 ("drm/nouveau: Queue hpd_work on (runtime)
> resume")]
-- 
Cheers,
	Lyude Paul

