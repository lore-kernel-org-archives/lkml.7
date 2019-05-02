Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE3720652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kJ/VcYvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfEBJfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:35:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38120 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:35:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so1371365lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLiW98ObQ1S6YFlruRE9Fln9ldebb9TO3ZMt7eGSCa4=;
        b=kJ/VcYvHyjnVugkqfWENJv99k8g6t5EVlK98yNTP787dS27OlftIdT80tN/vQeycG1
         OLXK58RYd2gV0AN/zXDeGH/7jYGtSmh27vXpnBU5/WBtDMrT3yNMJrOeykV2L9OnsWaM
         k0q4Ul2eAe/YiFvguNcj0qV85L6744P18qUjYPw4QM17PauwU9dw7t1UKV9G5chzTd3a
         freJak4M0M62x1Vp4lr3/3hdFX7R67+cCzCHre8/Hj7YG2e6jI+b0DyXSqN/6XL4NYjv
         znUwLiR/WoEaDmdfdiNAWx58cuDsNy5tHxIkU/9FYUyI3Ot3Pd20VpxN4qkegjx0tHvh
         Kg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLiW98ObQ1S6YFlruRE9Fln9ldebb9TO3ZMt7eGSCa4=;
        b=ZfV57kYVNaDRPgncOxZJi1YeD5iKOLOsw0lYweoJNdBBbfjvOzTEBV901cR4F3riYg
         pz+tFCnjqcNGoW7cqA/tiAQB6XiZkiI1FgjRaIzOdgGkk+XpU5JK5yanJ0DBttmUY78E
         WGtAKGoAflPwfjR7PZjc3hCsBcv1lCtkPa7Wu9pg7oGSEKqiWnVlXXKAXvg/9xOQ0jL9
         4QOXNwuHZ3bsgn8YUiE4+j7aPAntE2rZITOmHe++55cdJeTmjIyluHzcuZViENpVh7GL
         0b9gGBFQO0eeeI7+PLuCnxCPEmnVRGspTmxF1AP88qBrC2Y2WnIUsi4ADEYrN15FbarA
         umLw==
X-Gm-Message-State: APjAAAXQ/NOmXN4T5Jn8dvX6QRAco9sr4cKpzVwy324gH0eyQzl7IU3l
        aieKnlvM89FMjKozJezG92iqM8KegIeCcDyrg/X3NA==
X-Google-Smtp-Source: APXvYqzbPMzpxD0RPAZhpWdShx/+nGO7oeIUDQ2/rulMH8m6jO3wZL7AozC29zzbdQkX6PEqZ8Xr/tJPlZ0x7ozzxpU=
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr1414737lfg.115.1556789745312;
 Thu, 02 May 2019 02:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-2-git-send-email-yash.shah@sifive.com> <20190425101318.GA8469@e107155-lin>
 <CAJ2_jOEBqBnorz9PcQp72Jjju9RX_P8mU=Gq+0xCCcWsBiJksw@mail.gmail.com>
 <20190426093358.GA28309@e107155-lin> <CAJ2_jOEoD=Njp+L+H=jG59mA-j9SnwzyNmz7ECogWmbvei_f5Q@mail.gmail.com>
 <20190502004130.GA20802@bogus> <CAJ2_jOETZa_oC-xSwfQVw-9Q6OivRG2R0rKMhwCk1knbxWJQVw@mail.gmail.com>
 <20190502091044.GD12498@e107155-lin>
In-Reply-To: <20190502091044.GD12498@e107155-lin>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 2 May 2019 15:05:08 +0530
Message-ID: <CAJ2_jOG7a=gnxWiZ+mDW6KH9cWZC1HO7ZuwCiXBQJuNJJ1NBHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Add DT documentation for SiFive L2 Cache Controller
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> Sorry if I created confusion. I just wanted a note saying all the properties
> in ePAPR/DeviceTree specification applies for this platform. That would
> help me check if the standard cacheinfo infrastruction works as is or not.

Sure, will add this note.

- Yash
>
> --
> Regards,
> Sudeep
