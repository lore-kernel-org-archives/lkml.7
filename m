Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F00DECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227952067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdYZUFJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389948AbfJOWf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:35:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732584AbfJOWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571178924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9F2rYjWK9ziFocCIMNfTpax2GOtKztQS4lutNS8gIlc=;
        b=TdYZUFJHhW3E+hoz1mNOtbQGN9m3QYlLjkaMHMLvLbvQjKFEBKGUClfNNArlLRUvXqMoJA
        QfwfJB6gJ/Jn/X4UQqJg2gmv4c1hPjH4nbpky/okjiZOkp0J3bsEeyxNNd/TrJufZ8qQK2
        lf5CpQiFOzf1hgA1pv1JFRvq5NejKEI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-uWFmMppVMBaOFWHYweoqNw-1; Tue, 15 Oct 2019 18:35:22 -0400
Received: by mail-wm1-f70.google.com with SMTP id n3so318901wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Klw9BBs/uRXS08lOiDz40aM4kc+jmIjD/L7OQgU9RpQ=;
        b=FWLAyKCb+EcJzMZMnND0OUaJ6wcO/qzc68OOoPbQu3/3dsN5PFM6KDwtHAgs/TZP/p
         Tcq7NoInN+tA81xxhzUpukuWSX9ZRPlZtU4gSlmER2FTYrLbE8VxBaqyf7gGAUUZrI3Z
         KzcjeW9J/XUkMDIhCXECB7I4dm1F6EWG90N+ojXsFJZIergEYJhgwcx4RA2hRvLfzuZC
         7kE6oNrAsXWHVrzs9XD0EULyF4BF0y01eISnIo52F8Lc5rvRHSWpnpT9Uk4BzMGOJVK/
         xq9BJGcQ/fbf5QeSInu5X39zIZFsbb1lACJiRFN3RtGUon0KKvxJbI/FbiiOCBqbx/h/
         EMNQ==
X-Gm-Message-State: APjAAAVs3enNZXTZhmvEJhH+7RuSSTxy8U4fzZ2zUwkSjXXoUQuo1Rwj
        N0/1ShPXINac6XijvG1u6aw5FW3qjdtiAg9X5J/B2fHQjBMyJzufIYNzfmWq4cub74T7yx4dSMI
        fRhVSbKSGevxbICDVx+pxzWRi
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr548005wmc.11.1571178920976;
        Tue, 15 Oct 2019 15:35:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1iyLLTiDLs+t2SLsnm7KLC4V/LNTF3V6ZsBtx2m2Wming/W18J0rGV7YsyfVCmmOqtU/SdA==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr547985wmc.11.1571178920686;
        Tue, 15 Oct 2019 15:35:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id y13sm33305655wrg.8.2019.10.15.15.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:35:20 -0700 (PDT)
Subject: Re: [PATCH v5 3/6] timekeeping: Add clocksource to
 system_time_snapshot
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jianyong Wu <jianyong.wu@arm.com>
Cc:     netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Steve.Capper@arm.com, Kaly.Xin@arm.com,
        justin.he@arm.com, nd@arm.com
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-4-jianyong.wu@arm.com>
 <alpine.DEB.2.21.1910152047490.2518@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfa31e7c-83c4-0e16-ff7d-c6d6f0160e98@redhat.com>
Date:   Wed, 16 Oct 2019 00:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910152047490.2518@nanos.tec.linutronix.de>
Content-Language: en-US
X-MC-Unique: uWFmMppVMBaOFWHYweoqNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 22:12, Thomas Gleixner wrote:
> @@ -91,6 +96,7 @@ struct clocksource {
>  =09const char *name;
>  =09struct list_head list;
>  =09int rating;
> +=09enum clocksource_ids id;

Why add a global id?  ARM can add it to archdata similar to how x86 has
vclock_mode.  But I still think the right thing to do is to include the
full system_counterval_t in the result of ktime_get_snapshot.  (More in
a second, feel free to reply to the other email only).

Paolo

