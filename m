Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC51BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80BC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408351AbfITIxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:53:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34536 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405494AbfITIxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:53:35 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iBDzj-0002t2-IQ; Fri, 20 Sep 2019 18:10:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Sep 2019 18:10:17 +1000
Date:   Fri, 20 Sep 2019 18:10:17 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yuehaibing <yuehaibing@huawei.com>,
        Bjorn Helgaas <bjorn.helgaas@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Pascal van Leeuwen <pvanleeuwen@insidesecure.com>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/crypto/inside-secure/safexcel.c:840:9: error: implicit
 declaration of function 'pci_irq_vector'; did you mean 'rcu_irq_enter'?
Message-ID: <20190920081016.GA3663@gondor.apana.org.au>
References: <201909200943.xYWyp0BG%lkp@intel.com>
 <91bcb10e-ef1a-3979-d597-999552114746@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bcb10e-ef1a-3979-d597-999552114746@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 01:45:21PM +0800, Yuehaibing wrote:
> Herbert,
> 
> This has been fixed in below patch, but I can't find it in linux-next.
> 
> https://patchwork.kernel.org/patch/11129983/

I'm waiting for Bjorn to ack it.  Bjorn?

> On 2019/9/20 9:03, kbuild test robot wrote:
> > Hi Pascal,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   574cc4539762561d96b456dbc0544d8898bd4c6e
> > commit: 625f269a5a7a3643771320387e474bd0a61d9654 crypto: inside-secure - add support for PCI based FPGA development board
> > date:   3 weeks ago
> > config: sh-allmodconfig (attached as .config)
> > compiler: sh4-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 625f269a5a7a3643771320387e474bd0a61d9654
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=sh 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/crypto/inside-secure/safexcel.c: In function 'safexcel_request_ring_irq':
> >>> drivers/crypto/inside-secure/safexcel.c:840:9: error: implicit declaration of function 'pci_irq_vector'; did you mean 'rcu_irq_enter'? [-Werror=implicit-function-declaration]
> >       irq = pci_irq_vector(pci_pdev, irqid);
> >             ^~~~~~~~~~~~~~
> >             rcu_irq_enter
> >    drivers/crypto/inside-secure/safexcel.c: In function 'safexcel_probe_generic':
> >>> drivers/crypto/inside-secure/safexcel.c:1043:9: error: implicit declaration of function 'pci_alloc_irq_vectors'; did you mean 'pci_alloc_consistent'? [-Werror=implicit-function-declaration]
> >       ret = pci_alloc_irq_vectors(pci_pdev,
> >             ^~~~~~~~~~~~~~~~~~~~~
> >             pci_alloc_consistent
> >>> drivers/crypto/inside-secure/safexcel.c:1046:10: error: 'PCI_IRQ_MSI' undeclared (first use in this function); did you mean 'IRQ_MSK'?
> >              PCI_IRQ_MSI | PCI_IRQ_MSIX);
> >              ^~~~~~~~~~~
> >              IRQ_MSK
> >    drivers/crypto/inside-secure/safexcel.c:1046:10: note: each undeclared identifier is reported only once for each function it appears in
> >>> drivers/crypto/inside-secure/safexcel.c:1046:24: error: 'PCI_IRQ_MSIX' undeclared (first use in this function); did you mean 'PCI_IRQ_MSI'?
> >              PCI_IRQ_MSI | PCI_IRQ_MSIX);
> >                            ^~~~~~~~~~~~
> >                            PCI_IRQ_MSI
> >    drivers/crypto/inside-secure/safexcel.c: In function 'safexcel_init':
> >    drivers/crypto/inside-secure/safexcel.c:1402:6: warning: unused variable 'rc' [-Wunused-variable]
> >      int rc;
> >          ^~
> >    cc1: some warnings being treated as errors
> > 
> > vim +840 drivers/crypto/inside-secure/safexcel.c
> > 
> >    826	
> >    827	static int safexcel_request_ring_irq(void *pdev, int irqid,
> >    828					     int is_pci_dev,
> >    829					     irq_handler_t handler,
> >    830					     irq_handler_t threaded_handler,
> >    831					     struct safexcel_ring_irq_data *ring_irq_priv)
> >    832	{
> >    833		int ret, irq;
> >    834		struct device *dev;
> >    835	
> >    836		if (IS_ENABLED(CONFIG_PCI) && is_pci_dev) {
> >    837			struct pci_dev *pci_pdev = pdev;
> >    838	
> >    839			dev = &pci_pdev->dev;
> >  > 840			irq = pci_irq_vector(pci_pdev, irqid);
> >    841			if (irq < 0) {
> >    842				dev_err(dev, "unable to get device MSI IRQ %d (err %d)\n",
> >    843					irqid, irq);
> >    844				return irq;
> >    845			}
> >    846		} else if (IS_ENABLED(CONFIG_OF)) {
> >    847			struct platform_device *plf_pdev = pdev;
> >    848			char irq_name[6] = {0}; /* "ringX\0" */
> >    849	
> >    850			snprintf(irq_name, 6, "ring%d", irqid);
> >    851			dev = &plf_pdev->dev;
> >    852			irq = platform_get_irq_byname(plf_pdev, irq_name);
> >    853	
> >    854			if (irq < 0) {
> >    855				dev_err(dev, "unable to get IRQ '%s' (err %d)\n",
> >    856					irq_name, irq);
> >    857				return irq;
> >    858			}
> >    859		}
> >    860	
> >    861		ret = devm_request_threaded_irq(dev, irq, handler,
> >    862						threaded_handler, IRQF_ONESHOT,
> >    863						dev_name(dev), ring_irq_priv);
> >    864		if (ret) {
> >    865			dev_err(dev, "unable to request IRQ %d\n", irq);
> >    866			return ret;
> >    867		}
> >    868	
> >    869		return irq;
> >    870	}
> >    871	
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> > 

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
