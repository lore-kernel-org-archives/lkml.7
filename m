Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56511C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA80216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lwgkM95E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1RXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:23:02 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46888 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK1RXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:23:02 -0500
Received: by mail-qv1-f68.google.com with SMTP id t9so513391qvh.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 09:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=dxY7m/07nwpEoPmFlWFEy/QedJrHJ2tQnhpGMIFFBPA=;
        b=lwgkM95EcPlajjkzOiW1CVT8SyikrffucLON3EJwUFlrJsyRMtR9+D5lB1ftY/W1Cz
         uV29sjkzC68x3BL0tvgjhO8SG6alfLg1F0kChIF7XXTKTBb2MLiyLGQjk1Pt33GZ5hts
         aa2JuCmLWsA6l3yEJlLCQbVj2vSO/BsXMeBZUxv81QYjPW1pDFPA6nsZNMVNR45ku2iW
         XXPKD82T0GJhc4pTQOhd7nVohud1azDF2SMVkUUii+nlqpp3NnWUPD1uAU/Q1F3QaE/0
         vMQz1y3Aa2CahQl/BlfOjtenF+BvMEzQF8XBV1BHpoomeWVua4NPHAIckFG5I1DsoBm0
         wwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=dxY7m/07nwpEoPmFlWFEy/QedJrHJ2tQnhpGMIFFBPA=;
        b=Y09SLBmg4JEql7hQcbQ6xqVwztd64CLDitcNKdP08c9Q3zDK4AlZ7Jn+f1NwoaIQg6
         fUQrR/pcqnyp4VXZGJHJQIDaMF2CTYFIrqj7NkDGNllOADyuicz3lcY2YlGdgTa6TkoJ
         R8UeyYQHlZE6enJdhv/RwQtXhJV0WjKs+DjpYNG+CKqsYyElpblTHuIKeH+5YMESqONc
         BCD9U7IX16z2sX2JVKvY5VTyyIz3TeffBmk4tTJ/ScPDRkz600NvpvIsRdHnjerl3l+c
         jJG5mxQlkDyzx49zXsSj6sqmhu3IjAx8NSvwmwBOSV0k+vPFatGxyRB5wRhiaWXquuKv
         vvxg==
X-Gm-Message-State: APjAAAXCnfAlX+jyGF7rabfqJLUUdL5evipkdovduExv24IkYgBKrCm6
        enLthCO9S7abnO/SF5OzqsAGhg==
X-Google-Smtp-Source: APXvYqxYRuvBPE0xGFypF88YG98wllF0IIMgWOkACR+5JbFUpq8+rry1pXmFuFbS4CnE5DVnRHzT7Q==
X-Received: by 2002:a0c:e90b:: with SMTP id a11mr11720436qvo.229.1574961779319;
        Thu, 28 Nov 2019 09:22:59 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j7sm8823693qkd.46.2019.11.28.09.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 09:22:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Thu, 28 Nov 2019 12:22:57 -0500
Message-Id: <D7EFF3C1-E603-4729-8ABE-EBB6994795BF@lca.pw>
References: <20191128154637.GO26807@dhcp22.suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <20191128154637.GO26807@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2019, at 10:46 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> I tend to push back on cleanups without a clear added value. In this
> particular case it is not about aesthetic or a personal feeling about
> the code though. Please read my comment with the ack.

I can only encourage you to push back more in general especially for those m=
icro-size cleanups. On the other hand, it could be arbitrary because once yo=
u are gone for vacations or some other reasons, it will be inconsistent of r=
eviewing. You are mostly of my first defense those days.=
