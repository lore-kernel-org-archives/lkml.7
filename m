Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B362AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795D420715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YAx+U48Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKOR7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:59:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54776 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOR7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:59:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFHs3gh038342;
        Fri, 15 Nov 2019 17:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=ahS36Jfs5Zk25CVDCNIK8017oYYQzf7z2EA7wbOd830=;
 b=YAx+U48YuPhwVDn3miuydyvn0ZANsJa9NFYS+Tmse48ra+FsnjSvdUiNK/LtNUUH9IMb
 pGN86QmyJj3JSeiSJjrkb/G8SqoY7VSzImfVSgTF29TAHvW4lLffbDLrPbLcbhkdbqo4
 ZLsk+viiJstO0AgKdgRtk7JH7jTNLCBvYdacFYO5NNWLQyNC0cbTPj+ipV/U6bXOAF+a
 bNW/HXov44ZIsBFzWHGvADUcIFjTRSWICU9jetm8O1hwsEETdCR26yVTkYxvYqG3nBfZ
 qsYuY0t7YU/3qom/b6PJTVSmk5T8ISuSLCob4OJJRlU2SIrgQFTI/DuPx1l7dXFKyM/a cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w9gxpms23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 17:59:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFHwunl139571;
        Fri, 15 Nov 2019 17:59:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w9h14wmyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 17:59:19 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAFHwp3n022039;
        Fri, 15 Nov 2019 17:58:51 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 09:58:51 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 79D206A0129; Fri, 15 Nov 2019 13:02:15 -0500 (EST)
Date:   Fri, 15 Nov 2019 13:02:15 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while
 allocation of command buffer
Message-ID: <20191115180215.GC23860@char.us.oracle.com>
References: <1573640672-10344-1-git-send-email-jpawar@cadence.com>
 <20191114025301.GD30608@b29397-desktop>
 <5b567d57-6206-24cf-5886-20e8b5a92a45@ti.com>
 <MN2PR07MB6288D92B4AB6CF1B622A797CC1700@MN2PR07MB6288.namprd07.prod.outlook.com>
 <cefc03a1-b70a-bb40-289e-fbf4f9c79faf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cefc03a1-b70a-bb40-289e-fbf4f9c79faf@ti.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:11:41PM +0200, Roger Quadros wrote:
> +Konrad

You can run Linux with CONFIG_DEBU_DMA and use debug_dma_dump_mappings() to=
 dump
and figure things out. See http://xenbits.xen.org/gitweb/?p=3Dxentesttools/=
bootstrap.git;a=3Dblob;f=3Droot_image/drivers/dump/dump_dma.c;h=3D2ba251a2f=
8c36c24c68762b3e4c9f76ea178238f;hb=3DHEAD

>=20
> Jayshri,
>=20
> On 15/11/2019 12:14, Jayshri Dajiram Pawar wrote:
> > > > > There is a problem when function driver allocate memory for buffer
> > > > > used by DMA from outside dma_mask space.
> > > > > It appears during testing f_tcm driver with cdns3 controller.
> > > > > In the result cdns3 driver was not able to map virtual buffer to =
DMA.
> > > > > This fix should be improved depending on dma_mask associated with
> > > device.
> > > > > Adding GFP_DMA32 flag while allocationg command data buffer only =
for
> > > > > 32 bit controllers.
> > > >=20
> > > > Hi Jayshri,
> > > >=20
> > > > This issue should be fixed by setting DMA_MASK correctly for
> > > > controller, you can't limit user's memory region. At usb_ep_queue, =
the
> > > > UDC driver will call DMA MAP API, for Cadence, it is
> > > usb_gadget_map_request_by_dev.
> > > > For the system without SMMU (IO-MMU), it will use swiotlb to make s=
ure
> > > > the data buffer used for DMA transfer is within DMA mask for
> > > > controller, There is a reserved low memory region for debounce buff=
er
> > > > in swiotlb use case.
> > > >=20
> > >=20
> > > /**
> > >    * struct usb_request - describes one i/o request
> > >    * @buf: Buffer used for data.  Always provide this; some controlle=
rs
> > >    *	only use PIO, or don't use DMA for some endpoints.
> > >    * @dma: DMA address corresponding to 'buf'.  If you don't set this
> > >    *	field, and the usb controller needs one, it is responsible
> > >    *	for mapping and unmapping the buffer.
> > > <snip>
> > >    */
> > >=20
> > > So if dma is not set in the usb_request then controller driver is res=
ponsible to
> > > do a dma_map of the buffer pointed by 'buf' before it attemps to do D=
MA.
> > > This should take care of DMA mask and swiotlb.
> > >=20
> > > This patch is not correct.
> > >=20
> > Hi Roger,
> >=20
> > We have scatter-gather disabled.
> > We are getting below error while allocation of cmd data buffer with len=
gth 524288 or greater, while writing large size files to device.
> > This error occurred on x86 platform.
> > Because of this reason we have added DMA flag while allocation of buffe=
r.
> >=20
> > [ 1602.977532] swiotlb_tbl_map_single: 26 callbacks suppressed
> > [ 1602.977536] cdns-usb3 cdns-usb3.1: swiotlb buffer is full (sz: 52428=
8 bytes), total 32768 (slots), used 0 (slots)
>=20
> Why is swiotlb buffer getting full? How much is it on your system?
> Are you sure that dma_unmap is happening on requests that complete? else =
we'll just keep hogging the swiotlb buffer.
>=20
> cheers,
> -roger
>=20
> > [ 1602.977542] cdns-usb3 cdns-usb3.1: overflow 0x00000007eee00000+52428=
8 of DMA mask ffffffff bus mask 0
> > [ 1602.977555] WARNING: CPU: 6 PID: 285 at kernel/dma/direct.c:43 repor=
t_addr+0x37/0x60
> > [ 1602.977556] Modules linked in: target_core_user uio target_core_pscs=
i target_core_file target_core_iblock usb_f_tcm(OE) target_core_mod cdns3(O=
E) cdns3_pci_wrap(OE) roles(E) libcomposite(OE) udc_core(OE) xt_multiport i=
ptable_filter bpfilter snd_hda_codec_hdmi nls_iso8859_1 i915 intel_rapl x86=
_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_hda_codec_rea=
ltek snd_hda_codec_generic ledtrig_audio snd_hda_intel irqbypass snd_hda_co=
dec snd_hda_core snd_hwdep snd_pcm drm_kms_helper snd_seq_midi snd_seq_midi=
_event crct10dif_pclmul snd_rawmidi crc32_pclmul drm snd_seq ghash_clmulni_=
intel snd_seq_device aesni_intel snd_timer mei_me i2c_algo_bit aes_x86_64 c=
rypto_simd cryptd fb_sys_fops glue_helper snd mei input_leds syscopyarea in=
tel_cstate sysfillrect intel_rapl_perf sysimgblt hp_wmi soundcore sparse_ke=
ymap serio_raw wmi_bmof tpm_infineon mac_hid sch_fq_codel parport_pc ppdev =
lp parport ip_tables x_tables autofs4 hid_generic usbhid hid e1000e psmouse=
 ahci lpc_ich libahci i2c_i801 wmi
> > [ 1602.977605]  video
> > [ 1602.977613] CPU: 6 PID: 285 Comm: kworker/6:2 Tainted: G           O=
E     5.2.0-rc3cdns3-jayshri-stream-common+ #7
> > [ 1602.977615] Hardware name: Hewlett-Packard HP EliteDesk 800 G1 TWR/1=
8E4, BIOS L01 v02.21 12/17/2013
> > [ 1602.977623] Workqueue: tcm_usb_gadget usbg_cmd_work [usb_f_tcm]
> > [ 1602.977628] RIP: 0010:report_addr+0x37/0x60
> > [ 1602.977631] Code: 48 8b 87 28 02 00 00 48 89 75 f8 48 85 c0 74 2a 4c=
 8b 00 b8 fe ff ff ff 49 39 c0 76 11 80 3d af 61 72 01 00 0f 84 df 06 00 00=
 <0f> 0b c9 c3 48 83 bf 38 02 00 00 00 74 f2 eb e3 80 3d 93 61 72 01
> > [ 1602.977634] RSP: 0018:ffffa0a6834dfc00 EFLAGS: 00010046
> > [ 1602.977636] RAX: 0000000000000000 RBX: ffff8ec574aeb010 RCX: 0000000=
000000000
> > [ 1602.977638] RDX: 0000000000000007 RSI: 0000000000000086 RDI: 0000000=
000000000
> > [ 1602.977640] RBP: ffffa0a6834dfc08 R08: 0000000000000569 R09: fffffff=
fa2189fb8
> > [ 1602.977642] R10: 0000000000000069 R11: ffffa0a6834df940 R12: 0000000=
000080000
> > [ 1602.977644] R13: ffff8ec5ad536218 R14: ffff8ec5ad693800 R15: ffff8ec=
5ad693800
> > [ 1602.977647] FS:  0000000000000000(0000) GS:ffff8ec5be980000(0000) kn=
lGS:0000000000000000
> > [ 1602.977649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1602.977651] CR2: 00007f05a56b7000 CR3: 000000036fc0a006 CR4: 0000000=
0001606e0
> > [ 1602.977653] Call Trace:
> > [ 1602.977660]  dma_direct_map_page+0xdf/0xf0
> > [ 1602.977669]  usb_gadget_map_request_by_dev+0x17a/0x190 [udc_core]
> > [ 1602.977679]  __cdns3_gadget_ep_queue.isra.30+0x149/0x2e0 [cdns3]
> > [ 1602.977686]  ? kmalloc_order+0x18/0x40
> > [ 1602.977693]  cdns3_gadget_ep_queue+0x53/0x100 [cdns3]
> > [ 1602.977698]  usb_ep_queue+0x36/0xa0 [udc_core]
> > [ 1602.977704]  usbg_send_write_request+0x1ae/0x250 [usb_f_tcm]
> > [ 1602.977731]  transport_generic_new_cmd+0x1bc/0x320 [target_core_mod]
> > [ 1602.977749]  transport_handle_cdb_direct+0x42/0x60 [target_core_mod]
> > [ 1602.977766]  target_submit_cmd_map_sgls+0x176/0x230 [target_core_mod]
> > [ 1602.977771]  ? __switch_to_asm+0x40/0x70
> > [ 1602.977788]  target_submit_cmd+0x26/0x30 [target_core_mod]
> > [ 1602.977794]  usbg_cmd_work+0x60/0xd0 [usb_f_tcm]
> > [ 1602.977799]  process_one_work+0x20f/0x410
> > [ 1602.977802]  worker_thread+0x34/0x400
> > [ 1602.977807]  kthread+0x120/0x140
> > [ 1602.977811]  ? process_one_work+0x410/0x410
> > [ 1602.977815]  ? __kthread_parkme+0x70/0x70
> > [ 1602.977818]  ret_from_fork+0x35/0x40
> > [ 1602.977822] ---[ end trace 70f27f846049ae32 ]---
> > [ 1602.977826] cdns-usb3 cdns-usb3.1: failed to map buffer
> > [ 1602.977853] uasp_send_write_request(695)
> >=20
> > Regards,
> > Jayshri
> >=20
> > > cheers,
> > > -roger
> > >=20
> > > > Peter
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > > > > Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> > > > > ---
> > > > >    drivers/usb/gadget/function/f_tcm.c | 20 ++++++++++++++------
> > > > >    include/linux/usb/gadget.h          |  2 ++
> > > > >    2 files changed, 16 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/usb/gadget/function/f_tcm.c
> > > > > b/drivers/usb/gadget/function/f_tcm.c
> > > > > index 36504931b2d1..a78d5fad3d84 100644
> > > > > --- a/drivers/usb/gadget/function/f_tcm.c
> > > > > +++ b/drivers/usb/gadget/function/f_tcm.c
> > > > > @@ -213,7 +213,8 @@ static int bot_send_read_response(struct
> > > usbg_cmd *cmd)
> > > > >    	}
> > > > >=20
> > > > >    	if (!gadget->sg_supported) {
> > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > GFP_ATOMIC);
> > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > GFP_ATOMIC |
> > > > > +					gadget->dma_flag);
> > > > >    		if (!cmd->data_buf)
> > > > >    			return -ENOMEM;
> > > > >=20
> > > > > @@ -257,7 +258,8 @@ static int bot_send_write_request(struct
> > > usbg_cmd *cmd)
> > > > >    	}
> > > > >=20
> > > > >    	if (!gadget->sg_supported) {
> > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > GFP_KERNEL);
> > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_KERNEL
> > > |
> > > > > +					gadget->dma_flag);
> > > > >    		if (!cmd->data_buf)
> > > > >    			return -ENOMEM;
> > > > >=20
> > > > > @@ -305,6 +307,7 @@ static void bot_cmd_complete(struct usb_ep *e=
p,
> > > struct usb_request *req)
> > > > >    static int bot_prepare_reqs(struct f_uas *fu)
> > > > >    {
> > > > >    	int ret;
> > > > > +	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> > > > >=20
> > > > >    	fu->bot_req_in =3D usb_ep_alloc_request(fu->ep_in, GFP_KERNEL=
);
> > > > >    	if (!fu->bot_req_in)
> > > > > @@ -327,7 +330,8 @@ static int bot_prepare_reqs(struct f_uas *fu)
> > > > >    	fu->bot_status.req->complete =3D bot_status_complete;
> > > > >    	fu->bot_status.csw.Signature =3D cpu_to_le32(US_BULK_CS_SIGN);
> > > > >=20
> > > > > -	fu->cmd.buf =3D kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
> > > > > +	fu->cmd.buf =3D kmalloc(fu->ep_out->maxpacket, GFP_KERNEL |
> > > > > +				gadget->dma_flag);
> > > > >    	if (!fu->cmd.buf)
> > > > >    		goto err_buf;
> > > > >=20
> > > > > @@ -515,7 +519,8 @@ static int uasp_prepare_r_request(struct
> > > usbg_cmd *cmd)
> > > > >    	struct uas_stream *stream =3D cmd->stream;
> > > > >=20
> > > > >    	if (!gadget->sg_supported) {
> > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > GFP_ATOMIC);
> > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > GFP_ATOMIC |
> > > > > +					gadget->dma_flag);
> > > > >    		if (!cmd->data_buf)
> > > > >    			return -ENOMEM;
> > > > >=20
> > > > > @@ -763,11 +768,13 @@ static int uasp_alloc_stream_res(struct f_u=
as
> > > > > *fu, struct uas_stream *stream)
> > > > >=20
> > > > >    static int uasp_alloc_cmd(struct f_uas *fu)
> > > > >    {
> > > > > +	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> > > > >    	fu->cmd.req =3D usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
> > > > >    	if (!fu->cmd.req)
> > > > >    		goto err;
> > > > >=20
> > > > > -	fu->cmd.buf =3D kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
> > > > > +	fu->cmd.buf =3D kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL |
> > > > > +				gadget->dma_flag);
> > > > >    	if (!fu->cmd.buf)
> > > > >    		goto err_buf;
> > > > >=20
> > > > > @@ -980,7 +987,8 @@ static int usbg_prepare_w_request(struct
> > > usbg_cmd *cmd, struct usb_request *req)
> > > > >    	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> > > > >=20
> > > > >    	if (!gadget->sg_supported) {
> > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > GFP_ATOMIC);
> > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > GFP_ATOMIC |
> > > > > +					gadget->dma_flag);
> > > > >    		if (!cmd->data_buf)
> > > > >    			return -ENOMEM;
> > > > >=20
> > > > > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadge=
t.h
> > > > > index 124462d65eac..d6c9cd222600 100644
> > > > > --- a/include/linux/usb/gadget.h
> > > > > +++ b/include/linux/usb/gadget.h
> > > > > @@ -373,6 +373,7 @@ struct usb_gadget_ops {
> > > > >     * @connected: True if gadget is connected.
> > > > >     * @lpm_capable: If the gadget max_speed is FULL or HIGH, this=
 flag
> > > > >     *	indicates that it supports LPM as per the LPM ECN & errata.
> > > > > + * @dma_flag: dma zone to be used for buffer allocation.
> > > > >     *
> > > > >     * Gadgets have a mostly-portable "gadget driver" implementing=
 device
> > > > >     * functions, handling all usb configurations and interfaces.
> > > > > Gadget @@ -427,6 +428,7 @@ struct usb_gadget {
> > > > >    	unsigned			deactivated:1;
> > > > >    	unsigned			connected:1;
> > > > >    	unsigned			lpm_capable:1;
> > > > > +	unsigned int			dma_flag;
> > > > >    };
> > > > >    #define work_to_gadget(w)	(container_of((w), struct usb_gadget,
> > > work))
> > > > >=20
> > > > > --
> > > > > 2.20.1
> > > > >=20
> > > >=20
> > >=20
> > > --
> > > Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> > > Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
