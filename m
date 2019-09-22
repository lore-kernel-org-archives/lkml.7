Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14802C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D015F20869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Q9CxQCZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfIVWTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:19:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33958 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfIVWTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:19:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so7881138pfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PmAznyfs4k+mWd//xBrPme3TcumsUBoHQjEZq6u+NLY=;
        b=Q9CxQCZVN3CeKim3T14DI+dzH5PlCDTA8QmbsW+C8eax7IIA/NB0aFCLOE5uEMlnah
         n9HfkK054QH0pzmBa/MaaPHryLTCxiQvGwyx9m2DBJ3+fWXwG4tZ1JBoHBYs79JyChbx
         r5rFDF448s/NfZ2lrFLEI/35LniKtZVDGfAnyeOltNGUbu+hXauDlNLnNAaQqWncuzo2
         +3937Vc7WBUdbsp3LzrmK2ZIuYecnYyYnVMqeOVgiI0Tg/28mg73wkAS2nR2q0eakRY3
         9/YK/KVHUUOG6XAHJmFirHgZxtOEbFencrEJwS4yKpWhp/Wx/AxSLIA3VX7LS190gJnR
         PoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PmAznyfs4k+mWd//xBrPme3TcumsUBoHQjEZq6u+NLY=;
        b=VWbgOcR2kxzALjmHyVfuXOQYUzUBRVahwyArkulClvnSgOC1EXlq0EM10RstklwJ6d
         L+R9a1bVR+BVzE734Ifi4Wcd/pakpNK+/Isn5jpbvUX1R33/kp32zo3xlshQpbRGEzkz
         ywc+zYINbOiEAn9OHPvpZiFHy0GXiS+dS5HxLBwIUb7MK2/NC/uCTdZSyItkqPBsxpDg
         2nL2oqA5x1HYkN0HbhXysf0jU7L/2YvUX+U3T2HU2X7xzKDmgwsJJaeaj54+olulhncc
         MRq9HxtNY+/21OZ9I2aX0O8ohVwQ2levJlcDiiudIqX84Ok0KMTZKoiqJX+KM8qy+uDt
         iNlg==
X-Gm-Message-State: APjAAAWl4oxhrEbTykq0KC3/xdRjjfeYhf8cGgoYO1+vPsAcR0ioQm/4
        zeP8vFfO7ndg9Vj8bF8COGy12w==
X-Google-Smtp-Source: APXvYqzciIn5+C8G7UZYhYgLD06dOmlQZq70XrUrVD2u2KT92kUx/KmLzyi/sFi09I3djSRu2p/rmQ==
X-Received: by 2002:a17:90a:8087:: with SMTP id c7mr17644769pjn.56.1569190380757;
        Sun, 22 Sep 2019 15:13:00 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id r187sm7877357pfc.105.2019.09.22.15.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 15:13:00 -0700 (PDT)
Date:   Sun, 22 Sep 2019 15:12:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Christophe Roullier <christophe.roullier@st.com>
Cc:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>
Subject: Re: [PATCH  0/5] net: ethernet: stmmac: some fixes and optimization
Message-ID: <20190922151257.51173d89@cakuba.netronome.com>
In-Reply-To: <20190920053817.13754-1-christophe.roullier@st.com>
References: <20190920053817.13754-1-christophe.roullier@st.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 07:38:12 +0200, Christophe Roullier wrote:
> Some improvements (manage syscfg as optional clock, update slew rate of
> ETH_MDIO pin, Enable gating of the MAC TX clock during TX low-power mode)
> Fix warning build message when W=1

There seems to be some new features/cleanups (or improvements as
you say) here. Could you explain the negative impact not applying 
these changes will have? Patches 1 and 3 in particular.

net-next is now closed [1], and will reopen some time after the merge
window is over. For now we are only expecting fixes for the net tree.

Could you (a) provide stronger motivation these changes are fixes; or
(b) separate the fixes from improvements?

Thank you!

[1] https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html
