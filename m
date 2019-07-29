Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8894217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbfG2P7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:59:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:25423 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388224AbfG2P7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:59:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 07:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,323,1559545200"; 
   d="gz'50?scan'50,208,50";a="176433215"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2019 07:52:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hs714-000BI8-9H; Mon, 29 Jul 2019 22:52:46 +0800
Date:   Mon, 29 Jul 2019 22:51:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     kbuild-all@01.org, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH] usb: storage: sddr55: Fix a possible null-pointer
 dereference in sddr55_transport()
Message-ID: <201907292240.6KnIxzNk%lkp@intel.com>
References: <20190729100555.2081-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="knvs5jpuzwiaggrx"
Content-Disposition: inline
In-Reply-To: <20190729100555.2081-1-baijiaju1990@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--knvs5jpuzwiaggrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jia-Ju,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc2 next-20190729]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jia-Ju-Bai/usb-storage-sddr55-Fix-a-possible-null-pointer-dereference-in-sddr55_transport/20190729-204126
config: x86_64-randconfig-s0-07291935 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/usb/storage/sddr55.c: In function 'sddr55_transport':
>> drivers/usb/storage/sddr55.c:952:4: warning: 'pba' may be used uninitialized in this function [-Wmaybe-uninitialized]
       usb_stor_dbg(us, "WRITE_10: write block %04X (LBA %04X) page %01X pages %d\n",
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             pba, lba, page, pages);
             ~~~~~~~~~~~~~~~~~~~~~~

vim +/pba +952 drivers/usb/storage/sddr55.c

^1da177e4c3f415 Linus Torvalds 2005-04-16   769  
^1da177e4c3f415 Linus Torvalds 2005-04-16   770  
^1da177e4c3f415 Linus Torvalds 2005-04-16   771  /*
^1da177e4c3f415 Linus Torvalds 2005-04-16   772   * Transport for the Sandisk SDDR-55
^1da177e4c3f415 Linus Torvalds 2005-04-16   773   */
70fcc0050733a7c Alan Stern     2009-02-12   774  static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
^1da177e4c3f415 Linus Torvalds 2005-04-16   775  {
^1da177e4c3f415 Linus Torvalds 2005-04-16   776  	int result;
^1da177e4c3f415 Linus Torvalds 2005-04-16   777  	static unsigned char inquiry_response[8] = {
^1da177e4c3f415 Linus Torvalds 2005-04-16   778  		0x00, 0x80, 0x00, 0x02, 0x1F, 0x00, 0x00, 0x00
^1da177e4c3f415 Linus Torvalds 2005-04-16   779  	};
^1da177e4c3f415 Linus Torvalds 2005-04-16   780   	// write-protected for now, no block descriptor support
^1da177e4c3f415 Linus Torvalds 2005-04-16   781  	static unsigned char mode_page_01[20] = {
^1da177e4c3f415 Linus Torvalds 2005-04-16   782  		0x0, 0x12, 0x00, 0x80, 0x0, 0x0, 0x0, 0x0,
^1da177e4c3f415 Linus Torvalds 2005-04-16   783  		0x01, 0x0A,
^1da177e4c3f415 Linus Torvalds 2005-04-16   784  		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
^1da177e4c3f415 Linus Torvalds 2005-04-16   785  	};
^1da177e4c3f415 Linus Torvalds 2005-04-16   786  	unsigned char *ptr = us->iobuf;
^1da177e4c3f415 Linus Torvalds 2005-04-16   787  	unsigned long capacity;
^1da177e4c3f415 Linus Torvalds 2005-04-16   788  	unsigned int lba;
^1da177e4c3f415 Linus Torvalds 2005-04-16   789  	unsigned int pba;
^1da177e4c3f415 Linus Torvalds 2005-04-16   790  	unsigned int page;
^1da177e4c3f415 Linus Torvalds 2005-04-16   791  	unsigned short pages;
^1da177e4c3f415 Linus Torvalds 2005-04-16   792  	struct sddr55_card_info *info;
^1da177e4c3f415 Linus Torvalds 2005-04-16   793  
^1da177e4c3f415 Linus Torvalds 2005-04-16   794  	if (!us->extra) {
887c2560b6ceb5f Oliver Neukum  2006-01-08   795  		us->extra = kzalloc(
^1da177e4c3f415 Linus Torvalds 2005-04-16   796  			sizeof(struct sddr55_card_info), GFP_NOIO);
^1da177e4c3f415 Linus Torvalds 2005-04-16   797  		if (!us->extra)
^1da177e4c3f415 Linus Torvalds 2005-04-16   798  			return USB_STOR_TRANSPORT_ERROR;
^1da177e4c3f415 Linus Torvalds 2005-04-16   799  		us->extra_destructor = sddr55_card_info_destructor;
^1da177e4c3f415 Linus Torvalds 2005-04-16   800  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   801  
^1da177e4c3f415 Linus Torvalds 2005-04-16   802  	info = (struct sddr55_card_info *)(us->extra);
^1da177e4c3f415 Linus Torvalds 2005-04-16   803  
^1da177e4c3f415 Linus Torvalds 2005-04-16   804  	if (srb->cmnd[0] == REQUEST_SENSE) {
191648d03d20229 Joe Perches    2013-04-19   805  		usb_stor_dbg(us, "request sense %02x/%02x/%02x\n",
191648d03d20229 Joe Perches    2013-04-19   806  			     info->sense_data[2],
191648d03d20229 Joe Perches    2013-04-19   807  			     info->sense_data[12],
191648d03d20229 Joe Perches    2013-04-19   808  			     info->sense_data[13]);
^1da177e4c3f415 Linus Torvalds 2005-04-16   809  
^1da177e4c3f415 Linus Torvalds 2005-04-16   810  		memcpy (ptr, info->sense_data, sizeof info->sense_data);
^1da177e4c3f415 Linus Torvalds 2005-04-16   811  		ptr[0] = 0x70;
^1da177e4c3f415 Linus Torvalds 2005-04-16   812  		ptr[7] = 11;
^1da177e4c3f415 Linus Torvalds 2005-04-16   813  		usb_stor_set_xfer_buf (ptr, sizeof info->sense_data, srb);
^1da177e4c3f415 Linus Torvalds 2005-04-16   814  		memset (info->sense_data, 0, sizeof info->sense_data);
^1da177e4c3f415 Linus Torvalds 2005-04-16   815  
^1da177e4c3f415 Linus Torvalds 2005-04-16   816  		return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   817  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   818  
^1da177e4c3f415 Linus Torvalds 2005-04-16   819  	memset (info->sense_data, 0, sizeof info->sense_data);
^1da177e4c3f415 Linus Torvalds 2005-04-16   820  
f0183a338e4f90e Felipe Balbi   2016-04-18   821  	/*
f0183a338e4f90e Felipe Balbi   2016-04-18   822  	 * Dummy up a response for INQUIRY since SDDR55 doesn't
f0183a338e4f90e Felipe Balbi   2016-04-18   823  	 * respond to INQUIRY commands
f0183a338e4f90e Felipe Balbi   2016-04-18   824  	 */
^1da177e4c3f415 Linus Torvalds 2005-04-16   825  
^1da177e4c3f415 Linus Torvalds 2005-04-16   826  	if (srb->cmnd[0] == INQUIRY) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   827  		memcpy(ptr, inquiry_response, 8);
^1da177e4c3f415 Linus Torvalds 2005-04-16   828  		fill_inquiry_response(us, ptr, 36);
^1da177e4c3f415 Linus Torvalds 2005-04-16   829  		return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   830  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   831  
f0183a338e4f90e Felipe Balbi   2016-04-18   832  	/*
f0183a338e4f90e Felipe Balbi   2016-04-18   833  	 * only check card status if the map isn't allocated, ie no card seen yet
^1da177e4c3f415 Linus Torvalds 2005-04-16   834  	 * or if it's been over half a second since we last accessed it
^1da177e4c3f415 Linus Torvalds 2005-04-16   835  	 */
^1da177e4c3f415 Linus Torvalds 2005-04-16   836  	if (info->lba_to_pba == NULL || time_after(jiffies, info->last_access + HZ/2)) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   837  
^1da177e4c3f415 Linus Torvalds 2005-04-16   838  		/* check to see if a card is fitted */
^1da177e4c3f415 Linus Torvalds 2005-04-16   839  		result = sddr55_status (us);
^1da177e4c3f415 Linus Torvalds 2005-04-16   840  		if (result) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   841  			result = sddr55_status (us);
^1da177e4c3f415 Linus Torvalds 2005-04-16   842  			if (!result) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   843  			set_sense_info (6, 0x28, 0);	/* new media, set unit attention, not ready to ready */
^1da177e4c3f415 Linus Torvalds 2005-04-16   844  			}
^1da177e4c3f415 Linus Torvalds 2005-04-16   845  			return USB_STOR_TRANSPORT_FAILED;
^1da177e4c3f415 Linus Torvalds 2005-04-16   846  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16   847  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   848  
f0183a338e4f90e Felipe Balbi   2016-04-18   849  	/*
f0183a338e4f90e Felipe Balbi   2016-04-18   850  	 * if we detected a problem with the map when writing,
f0183a338e4f90e Felipe Balbi   2016-04-18   851  	 * don't allow any more access
f0183a338e4f90e Felipe Balbi   2016-04-18   852  	 */
^1da177e4c3f415 Linus Torvalds 2005-04-16   853  	if (info->fatal_error) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   854  
^1da177e4c3f415 Linus Torvalds 2005-04-16   855  		set_sense_info (3, 0x31, 0);
^1da177e4c3f415 Linus Torvalds 2005-04-16   856  		return USB_STOR_TRANSPORT_FAILED;
^1da177e4c3f415 Linus Torvalds 2005-04-16   857  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   858  
^1da177e4c3f415 Linus Torvalds 2005-04-16   859  	if (srb->cmnd[0] == READ_CAPACITY) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   860  
^1da177e4c3f415 Linus Torvalds 2005-04-16   861  		capacity = sddr55_get_capacity(us);
^1da177e4c3f415 Linus Torvalds 2005-04-16   862  
^1da177e4c3f415 Linus Torvalds 2005-04-16   863  		if (!capacity) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   864  			set_sense_info (3, 0x30, 0); /* incompatible medium */
^1da177e4c3f415 Linus Torvalds 2005-04-16   865  			return USB_STOR_TRANSPORT_FAILED;
^1da177e4c3f415 Linus Torvalds 2005-04-16   866  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16   867  
^1da177e4c3f415 Linus Torvalds 2005-04-16   868  		info->capacity = capacity;
^1da177e4c3f415 Linus Torvalds 2005-04-16   869  
f0183a338e4f90e Felipe Balbi   2016-04-18   870  		/*
f0183a338e4f90e Felipe Balbi   2016-04-18   871  		 * figure out the maximum logical block number, allowing for
f0183a338e4f90e Felipe Balbi   2016-04-18   872  		 * the fact that only 250 out of every 256 are used
f0183a338e4f90e Felipe Balbi   2016-04-18   873  		 */
^1da177e4c3f415 Linus Torvalds 2005-04-16   874  		info->max_log_blks = ((info->capacity >> (info->pageshift + info->blockshift)) / 256) * 250;
^1da177e4c3f415 Linus Torvalds 2005-04-16   875  
f0183a338e4f90e Felipe Balbi   2016-04-18   876  		/*
f0183a338e4f90e Felipe Balbi   2016-04-18   877  		 * Last page in the card, adjust as we only use 250 out of
f0183a338e4f90e Felipe Balbi   2016-04-18   878  		 * every 256 pages
f0183a338e4f90e Felipe Balbi   2016-04-18   879  		 */
^1da177e4c3f415 Linus Torvalds 2005-04-16   880  		capacity = (capacity / 256) * 250;
^1da177e4c3f415 Linus Torvalds 2005-04-16   881  
^1da177e4c3f415 Linus Torvalds 2005-04-16   882  		capacity /= PAGESIZE;
^1da177e4c3f415 Linus Torvalds 2005-04-16   883  		capacity--;
^1da177e4c3f415 Linus Torvalds 2005-04-16   884  
^1da177e4c3f415 Linus Torvalds 2005-04-16   885  		((__be32 *) ptr)[0] = cpu_to_be32(capacity);
^1da177e4c3f415 Linus Torvalds 2005-04-16   886  		((__be32 *) ptr)[1] = cpu_to_be32(PAGESIZE);
^1da177e4c3f415 Linus Torvalds 2005-04-16   887  		usb_stor_set_xfer_buf(ptr, 8, srb);
^1da177e4c3f415 Linus Torvalds 2005-04-16   888  
^1da177e4c3f415 Linus Torvalds 2005-04-16   889  		sddr55_read_map(us);
^1da177e4c3f415 Linus Torvalds 2005-04-16   890  
^1da177e4c3f415 Linus Torvalds 2005-04-16   891  		return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   892  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   893  
^1da177e4c3f415 Linus Torvalds 2005-04-16   894  	if (srb->cmnd[0] == MODE_SENSE_10) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   895  
^1da177e4c3f415 Linus Torvalds 2005-04-16   896  		memcpy(ptr, mode_page_01, sizeof mode_page_01);
^1da177e4c3f415 Linus Torvalds 2005-04-16   897  		ptr[3] = (info->read_only || info->force_read_only) ? 0x80 : 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16   898  		usb_stor_set_xfer_buf(ptr, sizeof(mode_page_01), srb);
^1da177e4c3f415 Linus Torvalds 2005-04-16   899  
^1da177e4c3f415 Linus Torvalds 2005-04-16   900  		if ( (srb->cmnd[2] & 0x3F) == 0x01 ) {
191648d03d20229 Joe Perches    2013-04-19   901  			usb_stor_dbg(us, "Dummy up request for mode page 1\n");
^1da177e4c3f415 Linus Torvalds 2005-04-16   902  			return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   903  
^1da177e4c3f415 Linus Torvalds 2005-04-16   904  		} else if ( (srb->cmnd[2] & 0x3F) == 0x3F ) {
191648d03d20229 Joe Perches    2013-04-19   905  			usb_stor_dbg(us, "Dummy up request for all mode pages\n");
^1da177e4c3f415 Linus Torvalds 2005-04-16   906  			return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   907  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16   908  
^1da177e4c3f415 Linus Torvalds 2005-04-16   909  		set_sense_info (5, 0x24, 0);	/* invalid field in command */
^1da177e4c3f415 Linus Torvalds 2005-04-16   910  		return USB_STOR_TRANSPORT_FAILED;
^1da177e4c3f415 Linus Torvalds 2005-04-16   911  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   912  
^1da177e4c3f415 Linus Torvalds 2005-04-16   913  	if (srb->cmnd[0] == ALLOW_MEDIUM_REMOVAL) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   914  
191648d03d20229 Joe Perches    2013-04-19   915  		usb_stor_dbg(us, "%s medium removal. Not that I can do anything about it...\n",
^1da177e4c3f415 Linus Torvalds 2005-04-16   916  			     (srb->cmnd[4]&0x03) ? "Prevent" : "Allow");
^1da177e4c3f415 Linus Torvalds 2005-04-16   917  
^1da177e4c3f415 Linus Torvalds 2005-04-16   918  		return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   919  
^1da177e4c3f415 Linus Torvalds 2005-04-16   920  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   921  
^1da177e4c3f415 Linus Torvalds 2005-04-16   922  	if (srb->cmnd[0] == READ_10 || srb->cmnd[0] == WRITE_10) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   923  
^1da177e4c3f415 Linus Torvalds 2005-04-16   924  		page = short_pack(srb->cmnd[3], srb->cmnd[2]);
^1da177e4c3f415 Linus Torvalds 2005-04-16   925  		page <<= 16;
^1da177e4c3f415 Linus Torvalds 2005-04-16   926  		page |= short_pack(srb->cmnd[5], srb->cmnd[4]);
^1da177e4c3f415 Linus Torvalds 2005-04-16   927  		pages = short_pack(srb->cmnd[8], srb->cmnd[7]);
^1da177e4c3f415 Linus Torvalds 2005-04-16   928  
^1da177e4c3f415 Linus Torvalds 2005-04-16   929  		page <<= info->smallpageshift;
^1da177e4c3f415 Linus Torvalds 2005-04-16   930  
^1da177e4c3f415 Linus Torvalds 2005-04-16   931  		// convert page to block and page-within-block
^1da177e4c3f415 Linus Torvalds 2005-04-16   932  
^1da177e4c3f415 Linus Torvalds 2005-04-16   933  		lba = page >> info->blockshift;
^1da177e4c3f415 Linus Torvalds 2005-04-16   934  		page = page & info->blockmask;
^1da177e4c3f415 Linus Torvalds 2005-04-16   935  
^1da177e4c3f415 Linus Torvalds 2005-04-16   936  		// locate physical block corresponding to logical block
^1da177e4c3f415 Linus Torvalds 2005-04-16   937  
^1da177e4c3f415 Linus Torvalds 2005-04-16   938  		if (lba >= info->max_log_blks) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   939  
191648d03d20229 Joe Perches    2013-04-19   940  			usb_stor_dbg(us, "Error: Requested LBA %04X exceeds maximum block %04X\n",
191648d03d20229 Joe Perches    2013-04-19   941  				     lba, info->max_log_blks - 1);
^1da177e4c3f415 Linus Torvalds 2005-04-16   942  
^1da177e4c3f415 Linus Torvalds 2005-04-16   943  			set_sense_info (5, 0x24, 0);	/* invalid field in command */
^1da177e4c3f415 Linus Torvalds 2005-04-16   944  
^1da177e4c3f415 Linus Torvalds 2005-04-16   945  			return USB_STOR_TRANSPORT_FAILED;
^1da177e4c3f415 Linus Torvalds 2005-04-16   946  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16   947  
09c020225d3b3bd Jia-Ju Bai     2019-07-29   948  		if (info->lba_to_pba)
^1da177e4c3f415 Linus Torvalds 2005-04-16   949  			pba = info->lba_to_pba[lba];
^1da177e4c3f415 Linus Torvalds 2005-04-16   950  
^1da177e4c3f415 Linus Torvalds 2005-04-16   951  		if (srb->cmnd[0] == WRITE_10) {
191648d03d20229 Joe Perches    2013-04-19  @952  			usb_stor_dbg(us, "WRITE_10: write block %04X (LBA %04X) page %01X pages %d\n",
^1da177e4c3f415 Linus Torvalds 2005-04-16   953  				     pba, lba, page, pages);
^1da177e4c3f415 Linus Torvalds 2005-04-16   954  
^1da177e4c3f415 Linus Torvalds 2005-04-16   955  			return sddr55_write_data(us, lba, page, pages);
^1da177e4c3f415 Linus Torvalds 2005-04-16   956  		} else {
191648d03d20229 Joe Perches    2013-04-19   957  			usb_stor_dbg(us, "READ_10: read block %04X (LBA %04X) page %01X pages %d\n",
^1da177e4c3f415 Linus Torvalds 2005-04-16   958  				     pba, lba, page, pages);
^1da177e4c3f415 Linus Torvalds 2005-04-16   959  
^1da177e4c3f415 Linus Torvalds 2005-04-16   960  			return sddr55_read_data(us, lba, page, pages);
^1da177e4c3f415 Linus Torvalds 2005-04-16   961  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16   962  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   963  
^1da177e4c3f415 Linus Torvalds 2005-04-16   964  
^1da177e4c3f415 Linus Torvalds 2005-04-16   965  	if (srb->cmnd[0] == TEST_UNIT_READY) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   966  		return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   967  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   968  
^1da177e4c3f415 Linus Torvalds 2005-04-16   969  	if (srb->cmnd[0] == START_STOP) {
^1da177e4c3f415 Linus Torvalds 2005-04-16   970  		return USB_STOR_TRANSPORT_GOOD;
^1da177e4c3f415 Linus Torvalds 2005-04-16   971  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16   972  
^1da177e4c3f415 Linus Torvalds 2005-04-16   973  	set_sense_info (5, 0x20, 0);	/* illegal command */
^1da177e4c3f415 Linus Torvalds 2005-04-16   974  
^1da177e4c3f415 Linus Torvalds 2005-04-16   975  	return USB_STOR_TRANSPORT_FAILED; // FIXME: sense buffer?
^1da177e4c3f415 Linus Torvalds 2005-04-16   976  }
^1da177e4c3f415 Linus Torvalds 2005-04-16   977  
aa519be34f45954 Akinobu Mita   2015-05-06   978  static struct scsi_host_template sddr55_host_template;
70fcc0050733a7c Alan Stern     2009-02-12   979  
70fcc0050733a7c Alan Stern     2009-02-12   980  static int sddr55_probe(struct usb_interface *intf,
70fcc0050733a7c Alan Stern     2009-02-12   981  			 const struct usb_device_id *id)
70fcc0050733a7c Alan Stern     2009-02-12   982  {
70fcc0050733a7c Alan Stern     2009-02-12   983  	struct us_data *us;
70fcc0050733a7c Alan Stern     2009-02-12   984  	int result;
70fcc0050733a7c Alan Stern     2009-02-12   985  
70fcc0050733a7c Alan Stern     2009-02-12   986  	result = usb_stor_probe1(&us, intf, id,
aa519be34f45954 Akinobu Mita   2015-05-06   987  			(id - sddr55_usb_ids) + sddr55_unusual_dev_list,
aa519be34f45954 Akinobu Mita   2015-05-06   988  			&sddr55_host_template);
70fcc0050733a7c Alan Stern     2009-02-12   989  	if (result)
70fcc0050733a7c Alan Stern     2009-02-12   990  		return result;
70fcc0050733a7c Alan Stern     2009-02-12   991  
70fcc0050733a7c Alan Stern     2009-02-12   992  	us->transport_name = "SDDR55";
70fcc0050733a7c Alan Stern     2009-02-12   993  	us->transport = sddr55_transport;
70fcc0050733a7c Alan Stern     2009-02-12   994  	us->transport_reset = sddr55_reset;
70fcc0050733a7c Alan Stern     2009-02-12   995  	us->max_lun = 0;
70fcc0050733a7c Alan Stern     2009-02-12   996  
70fcc0050733a7c Alan Stern     2009-02-12   997  	result = usb_stor_probe2(us);
70fcc0050733a7c Alan Stern     2009-02-12   998  	return result;
70fcc0050733a7c Alan Stern     2009-02-12   999  }
70fcc0050733a7c Alan Stern     2009-02-12  1000  
70fcc0050733a7c Alan Stern     2009-02-12  1001  static struct usb_driver sddr55_driver = {
aa519be34f45954 Akinobu Mita   2015-05-06  1002  	.name =		DRV_NAME,
70fcc0050733a7c Alan Stern     2009-02-12  1003  	.probe =	sddr55_probe,
70fcc0050733a7c Alan Stern     2009-02-12  1004  	.disconnect =	usb_stor_disconnect,
70fcc0050733a7c Alan Stern     2009-02-12  1005  	.suspend =	usb_stor_suspend,
70fcc0050733a7c Alan Stern     2009-02-12  1006  	.resume =	usb_stor_resume,
70fcc0050733a7c Alan Stern     2009-02-12  1007  	.reset_resume =	usb_stor_reset_resume,
70fcc0050733a7c Alan Stern     2009-02-12  1008  	.pre_reset =	usb_stor_pre_reset,
70fcc0050733a7c Alan Stern     2009-02-12  1009  	.post_reset =	usb_stor_post_reset,
70fcc0050733a7c Alan Stern     2009-02-12  1010  	.id_table =	sddr55_usb_ids,
70fcc0050733a7c Alan Stern     2009-02-12  1011  	.soft_unbind =	1,
e73b2db6c9bc5bd Huajun Li      2012-01-14  1012  	.no_dynamic_id = 1,
70fcc0050733a7c Alan Stern     2009-02-12  1013  };
70fcc0050733a7c Alan Stern     2009-02-12  1014  
aa519be34f45954 Akinobu Mita   2015-05-06  1015  module_usb_stor_driver(sddr55_driver, sddr55_host_template, DRV_NAME);

:::::: The code at line 952 was first introduced by commit
:::::: 191648d03d20229523d9a75b8abef56421298d28 usb: storage: Convert US_DEBUGP to usb_stor_dbg

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--knvs5jpuzwiaggrx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7iDqAvH/AYC5jDFcPAIA

--knvs5jpuzwiaggrx--
